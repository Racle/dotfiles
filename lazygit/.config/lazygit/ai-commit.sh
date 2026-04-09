#!/usr/bin/env bash
set -euo pipefail

SELECTED_TYPE="$1"
COMMITS_TO_SUGGEST=8

# Check for staged changes
if git diff --cached --quiet; then
  echo "No changes in staging. Add changes first."
  exit 1
fi

log_context=$(git log --oneline -10)
stat_context=$(git diff --cached --stat)

git diff --cached | opencode run "
You are an expert at writing Git commits. Your job is to write commit messages that follow the Conventional Commits format.

The user has selected: $SELECTED_TYPE

Your task is to:
1. Analyze the code changes provided via the attached file
2. Determine the most appropriate commit type (if user selected 'ai-defined')
3. Determine an appropriate scope (component/area affected)
4. Decide if this is a breaking change
5. Write clear, concise commit messages with a short title AND a longer description

Available commit types:
- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing tests or correcting existing tests
- build: Changes that affect the build system or external dependencies
- ci: Changes to CI configuration files and scripts
- chore: Other changes that don't modify src or test files
- revert: Reverts a previous commit

Follow these guidelines for the TITLE (before the |):
- Structure: <type>(<scope>): <description>
- If user selected 'ai-defined', analyze the changes and pick the most suitable type
- If user selected a specific type, use that type: $SELECTED_TYPE
- Add scope in parentheses if applicable (e.g., auth, api, ui, config)
- Use exclamation mark (!) after type/scope for breaking changes: type(scope)!: description
- Use lowercase for description (except proper nouns)
- Use imperative mood (\"add\", not \"added\")
- Keep description under 50 characters when possible
- No period at the end of subject line

Follow these guidelines for the DESCRIPTION (after the |):
- Explain what was changed and why in 1-2 sentences
- Provide context that the title alone cannot convey
- Mention side effects or important implementation details if relevant

OUTPUT FORMAT: Each line must be exactly: title | description
The pipe character (|) separates the short title from the longer description.

Examples:
- feat(auth): add OAuth login support | implement OAuth2 flow with Google and GitHub providers, add token refresh logic
- fix(api): handle null response in user endpoint | add null checks to prevent crashes when upstream service returns empty response bodies
- docs(readme): update installation instructions | rewrite setup guide to cover Docker-based workflow and remove outdated manual steps
- refactor(database): simplify query builder logic | replace nested conditionals with a composable pipeline pattern for better maintainability
- build(deps): upgrade React to version 18 | migrate from legacy ReactDOM.render to createRoot API as required by React 18
- perf(api)!: optimize database queries | replace N+1 queries with batch loading, breaking change in the query builder interface

IMPORTANT:
- Generate exactly $COMMITS_TO_SUGGEST different commit message options
- If user selected 'ai-defined', you can use different types for different options
- If user selected a specific type, all messages must use that type
- Only return commit messages in the format: title | description
- Do not use markdown code blocks or any formatting
- One message per line
- Each line MUST contain exactly one pipe character (|) separating title and description
- Do NOT use any tools. Only respond with text.

Previous commits for context:
$log_context

Changes summary:
$stat_context

The full diff is attached as a file.
" -f - -m github-copilot/claude-haiku-4.5 2>&1 | sed 's/^[[:space:]]*[-*]*[[:space:]]*//' | grep -E '^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.*\))?!?: .+ \| .+' || true
