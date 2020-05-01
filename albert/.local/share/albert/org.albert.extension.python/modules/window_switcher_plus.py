# -*- coding: utf-8 -*-

"""
X11 window switcher - list and activate windows.
to enable search on all workspaces start query with *
performs tokenized search-> order doesnt matter
fuzzy search can be enabled in settings

Installation: 
1. Place into ~/.local/share/albert/org.albert.extension.python/modules/window_switcher_plus.py
2. Enable Python plugin from albert
3. Enable Window Switcher Plus from python plugin list
4. Search by " <searchterm>" (or " *<searchterm>" to search from all workspaces IF separateWorkspaces is set to True)

History: 
Original (2019-01-03): https://github.com/albertlauncher/python/blob/dev/window_switcher.py
vthuongt fork (2019-03-27): https://github.com/vthuongt/window-switcher-plus
Racle's fork (2020-04-27): https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/window_switcher_plus.py


Changelog: 
Racle 2020-04-27:
- Added working icon finder
- added option separateWorkspaces. Turn to True to search from current workspace by default.
"""

import subprocess
from collections import namedtuple
from collections import defaultdict
from functools import reduce
from shutil import which
#from fuzzywuzzy import fuzz #https://chairnerd.seatgeek.com/fuzzywuzzy-fuzzy-string-matching-in-python/
import re
import os

import getpass
import socket

from albertv0 import Item, ProcAction, iconLookup


Window = namedtuple("Window", ["wid", "desktop", "wm_class", "host", "wm_name"])
# search algo inspired by https://github.com/daniellandau/switcher/blob/master/util.js

### Settings ###
username=getpass.getuser() #overwrite this if getpass.getuser() doesn't find your username
matchFuzzy = False
orderByRelevancy = True
separateWorkspaces = False

hostname=socket.gethostname()

__iid__ = "PythonInterface/v0.1"
__prettyname__ = "Window Switcher Plus"
__version__ = "1.7"
__trigger__ = " "
__author__ = "Ed Perez, Manuel Schneider, Viet Tran, Ville Viitaharju"
__dependencies__ = ["wmctrl"]

if which("wmctrl") is None:
    raise Exception("'wmctrl' is not in $PATH.")

def getWindows():
    windows = []
    for line in subprocess.check_output(['wmctrl', '-l', '-x']).splitlines():
        win = Window(*[token.decode() for token in line.split(None,4)])
        if win.desktop != "-1":
            windows.append(win)
    
    return windows

def createItems(windows, spans=None):
    results = []
    #print('spans: ', spans)
    #[print(w.wm_name) for w in windows]
    #print(len(windows))
    
    for win in windows:
        if spans:
            text_subtext = highlightText(win, spans[win.wid]) 
        else:
            if separateWorkspaces:
                text_subtext = {'text':'%s: %s' % (win.desktop, win.wm_class.split('.')[-1].replace('-',' ')),
                'subtext':'%s➜%s' %(win.wm_class.split('.')[-1], win.wm_name)}
            else:
                text_subtext = {'text':'%s' % (win.wm_class.split('.')[-1].replace('-',' ')),
                'subtext':'%s➜%s' %(win.wm_class.split('.')[-1], win.wm_name)}
    
    
        # custom icon search
        icon = getIcon(remove_prefix(win.wm_class, 'org.gnome.').split('.')[0])        
        # ex. teams is using host as "teams" instead of real hostname. This fixes teams icon
        if icon.strip() == '' and win.host.split('.')[0] != hostname:
            icon = getIcon(win.host.split('.')[0])   
        #ex fixes gnome-terminal
        if icon.strip() == '' and len(win.wm_class.replace('org.gnome.', '').split('.')) > 1:
            icon = getIcon(remove_prefix(win.wm_class, 'org.gnome.').split('.')[1].replace('-','.'))    

        
        results.append( Item(id="%s%s" % (__prettyname__, win.wm_class),
                                                **text_subtext,
                                                icon=icon,
                                                actions=[ProcAction(text="Switch Window",
                                                                    commandline=["wmctrl", '-i', '-a', win.wid] ),
                                                        ProcAction(text="Move window to this desktop",
                                                                    commandline=["wmctrl", '-i', '-R', win.wid] ),
                                                        ProcAction(text="Close the window gracefully.",
                                                                    commandline=["wmctrl", '-c', win.wid])]
                                                ))


    return results

def highlightText(win, spans):
    '''
    input: 
    spans: list(tuple(int, int)) - describing match positions
    '''

    # sort spans
    spans.sort(key=lambda x: x[0])
    
    # check spans not overlapping, this could be problem when doing fuzzy search

    if separateWorkspaces:
        text='%s: %s' % (win.desktop, win.wm_class.split('.')[-1].replace('-',' '))
    else:
        text='%s' % (win.wm_class.split('.')[-1].replace('-',' '))
    subtext = ''

    description = '%s➜%s' %(win.wm_class.split('.')[-1], win.wm_name)
    len_wm_class = len(win.wm_class.split('.')[-1].lower())

    last_pos = 0

    for s_init, s_end in spans:
        before = description[last_pos:s_init]
        highlight = description[s_init:s_end]

        subtext+='%s<u>%s</u>'% (before, highlight)
        last_pos = s_end

    subtext += description[last_pos:]
    return {'text':text, 'subtext':subtext }


def getCurrentWorkspace():
    for line in subprocess.check_output(['wmctrl', '-d']).splitlines():
        cols = line.split()
        if cols[1].decode() == '*':
            return cols[0].decode()
    
    return None

def filterWindows(query, curWS, windows):
    ''' if query starts with *, do search on all workspaces

    returns:
    windows: list[Window(=namedtuple)]
    spans: dict(window_id:[(match_0_start, match_0_end),...,(match_N_start, match_N_end) ] )
    '''
    if not query or not curWS or not windows:
        return [w for w in windows if w.desktop == curWS], None

    query =  query.split()
    #do not check workspace is separateWorkspaces is False
    if query[0].startswith('*') or separateWorkspaces == False:
        query[0] = query[0].strip('*')
        if query[0] == '': # inserted space after *
            del query[0]
            if len(query)==0:
                return windows, None
    else:
        windows = [w for w in windows if w.desktop == curWS]
    
    # for every window run every query token, add score
    scores = defaultdict(int)
    spans = defaultdict(list)
    for win in windows:
        wm_class = win.wm_class.split('.')[-1].lower()
        wm_name = win.wm_name
        descriptionLowerCase = '%s %s' %(wm_class, wm_name)
        score = 0
        
        for query_token in query:
            # print('search for  <%s> in <%s>'%(query_token,descriptionLowerCase))
            score, matchPos =  calculateScore(descriptionLowerCase, query_token)
            scores[win.wid] += score
            spans[win.wid].extend(matchPos)

            
        # print('score:', scores[win.wid])

    # remove score zero windows and sort
    windows = [w for w in windows if scores[w.wid] != 0 ]
    if orderByRelevancy:
        windows.sort(key=lambda x: scores[x.wid], reverse=True)
    else:
        windows.sort(key=lambda x: '%s %s' %(x.wm_class.split('.')[-1], x.wm_name), reverse=True)
    spans = { wid:sp for wid, sp in spans.items() if scores[wid] != 0 }
    # [print(w.wm_name, scores[w.wid]) for w in windows]
    return windows, spans
    


    
def calculateScore(description, query_token):
    if query_token == '':
        return True
    regexp = createRegExp(query_token)
    # print(regex)

    score = 0
    gotMatch = False
    spans = []

    for match in re.finditer(regexp, description,flags=re.I):
        # print('%s -> matches: %s'%(regexp, match))
        # A full match at the beginning is the best match
        if (match.start() == 0 and len(match.group(0)) == len(query_token)):
            score += 100
        
         # matches at beginning word boundaries are better than in the middle of words
        if( match.start() == 0 or (match.start != 0 and description[match.start() - 1] == ' ')):
            wordPrefixFactor = 1.2
        else:
            wordPrefixFactor = 0.0

        # matches nearer to the beginning are better than near the end
        precedenceFactor = 1.0 / (1 + match.start())

        # fuzzyness can cause lots of stuff to match, penalize by match length
        fuzzynessFactor = (2.3 * (len(query_token) - len(match.group(0))  )) / len(match.group(0))

        # join factors by summing
        newscore = precedenceFactor + wordPrefixFactor + fuzzynessFactor
        score = max(score, newscore)
        spans.append(match.span())
        gotMatch = True
    return score, spans



def createRegExp(query_token):
    regex = ''
    if matchFuzzy:
        query_token = [re.escape(x) for x in list(query_token)]
    else:
        query_token = [re.escape(query_token)]

    regex = reduce(lambda a,b: a + '[^' + b + ']*' + b, query_token)
    # print(regex)
    return regex
    


def handleQuery(query):
    if query.isTriggered:
        stripped = query.string.strip().lower()
        curWS =  getCurrentWorkspace()
        results = []
        windows = getWindows()

        windows, matchPos = filterWindows(stripped, curWS, windows)
        results = createItems(windows, spans=matchPos)

        
        return results


# search from 
# /var/lib/snapd/desktop/applications/
# /usr/share/applications
# ~/.local/share/applications

def getIconPath(icon, path):
    #print(icon, path)
    for root, dirs, files in os.walk(path):
        for file in files:
            if icon in file.lower():
                with open(os.path.join(root, file), 'r') as file:
                    for ln in file:
                        if ln.startswith('Icon'):
                            return ln[5:].replace('\n', '')
    return ''

def getIcon(icon):
    # lstrip for chrome installed apps
    icon = remove_prefix(icon.lower(), 'crx_')
    # check "normal way" first
    result = iconLookup(icon)
    # continue to custom search
    if result.strip() == "":
        result = getIconPath(icon, '/usr/share/applications') or getIconPath(icon, '/home/' + username + '/.local/share/applications') or getIconPath(icon, '/var/lib/snapd/desktop/applications/')
        if not result.startswith('/'):
            result = iconLookup(result)
    return result

def remove_prefix(text, prefix):
    if text.startswith(prefix):
        return text[len(prefix):]
    return text