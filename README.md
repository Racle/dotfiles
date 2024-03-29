# Dotfiles

## Clone repo

```
git clone https://github.com/Racle/dotfiles.git ~/.dotfiles
```

## Usage

### Install stow

```
sudo apt-get install stow
```

### Stow files

This will remove old files and symlink new ones

```
make stow
```

For server, use

```
make stow-server
```

## Manual usage

#### remove old files

```
rm ~/.zshrc ~/.p10k.zsh ~/.tmux.conf ~/.docker_aliases ~/.config/albert/albert.conf ~/.watchers.xml ~/.config/nvim/init.vim ~/.config/ranger/rc.conf
```

#### symlink dotfiles

```
cd ~/.dotfiles
stow default zsh albert tmux neovim ranger
```

On server, use

```
stow zsh-server
```

#### install zsh

`curl -fsSL https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/install-zsh.sh | sh -`

#### symlink zsh to root

```
sudo rm /root/.oh-my-zsh /root/.zshrc /root/.p10k.zsh /root/.docker_aliases
sudo ln -s $HOME/.oh-my-zsh /root/
sudo ln -s $HOME/.zshrc /root/
sudo ln -s $HOME/.p10k.zsh /root/
sudo ln -s $HOME/.docker_aliases /root/
```
