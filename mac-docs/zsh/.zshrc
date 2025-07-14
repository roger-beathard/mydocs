# --- Environment Variables ---
# Add custom paths to the PATH variable for executable lookup.
#  VS Code to path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# Prepend Homebrew's binary path to ensure its tools are used by default.
export PATH="/opt/homebrew/bin:$PATH"

# Initialize GCLOUD
export GCLOUD_HOME="$HOME/google-cloud-sdk"

# Configure colors for `ls` command.
# LSCOLORS is for BSD/macOS `ls`.
export LSCOLORS=Gxfxcxdxbxegedabagacad
# LS_COLORS is for GNU `ls` (often used on Linux).
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Set default options for the `less` command.
# -R allows `less` to output raw control characters, which enables color display.
export LESS=-R
# Set `less` as the default pager for commands like `man`.
export PAGER=less

# Set the Zsh configuration directory.
export ZSH="$HOME/.zsh"



# --- Shell Options ---

# History Configuration
export HISTSIZE=10000                 # How many commands to keep in memory for the current session.
export SAVEHIST=10000                 # How many commands to save in the history file.
export HISTFILE="$ZSH/.zsh_history"   # Where to save the history file.

setopt EXTENDED_HISTORY       # Add timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when trimming history
setopt HIST_IGNORE_SPACE      # Don't save commands starting with a space
setopt HIST_VERIFY            # Don't execute history commands immediately
setopt HIST_IGNORE_ALL_DUPS   # Don't save commands that are duplicates of any in history
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching history
setopt SHARE_HISTORY          # Share history between all sessions

# Navigation & Directory Stack
setopt AUTO_CD                # cd by typing directory name
setopt AUTO_PUSHD             # Automatically pushd on cd
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate directories
setopt PUSHD_MINUS            # Makes `cd -<n>` more intuitive

# Completion, Editing & General
setopt ALWAYS_TO_END          # Move cursor to the end of a completed word
setopt COMPLETE_IN_WORD       # Allow completion from within a word
setopt COMBINING_CHARS        # Handle Unicode combining characters correctly
setopt NO_FLOW_CONTROL        # Disable ^S/^Q to prevent terminal freezing
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell
setopt LONG_LIST_JOBS         # List jobs in long format by default
setopt PROMPT_SUBST           # Allow command substitution in prompt

# --- Zsh Initialization ---
# Add the zsh-completions plugin to the function path.
# This must be done *before* compinit so it can find the new completions.
#fpath=("$ZSH/plugins/zsh-completions-0.35.0/src" $fpath)

# Initialize the completion system
autoload -U compinit; compinit
# Enable colors in prompt
autoload -U colors && colors


# --- Functions ---
# Custom history function (from Oh My Zsh) to manage command history.
# Provides options to list, clear, or inspect history entries.
omz_history () {
	local clear list stamp REPLY
	zparseopts -E -D c=clear l=list f=stamp E=stamp i=stamp t:=stamp
	if [[ -n "$clear" ]]
	then
		print -nu2 "This action will irreversibly delete your command history. Are you sure? [y/N] "
		builtin read -E
		[[ "$REPLY" = [yY] ]] || return 0
		print -nu2 >| "$HISTFILE"
		fc -p "$HISTFILE"
		print -u2 History file deleted.
	elif [[ $# -eq 0 ]]
	then
		builtin fc "${stamp[@]}" -l 1
	else
		builtin fc "${stamp[@]}" -l "$@"
	fi
}

# --- Plugins & Keybindings ---
# Load zsh-autosuggestions: suggests commands as you type based on history.
source "$ZSH/plugins/zsh-autosuggestions-0.7.1/zsh-autosuggestions.zsh"
# Load zsh-history-substring-search: allows searching history with arrow keys
# based on what's currently typed on the command line.
source "$ZSH/plugins/zsh-history-substring-search-1.1.0/zsh-history-substring-search.zsh"
# Bind arrow keys to the history substring search functions.
bindkey '^[[A' history-substring-search-up   # Up arrow
bindkey '^[[B' history-substring-search-down # Down arrow

# Google Cloud SDK  
# The next line updates PATH for the Google Cloud SDK.
source $GCLOUD_HOME/path.zsh.inc

# The next line enables zsh completion for gcloud.
source $GCLOUD_HOME/completion.zsh.inc

# --- Aliases ---
# Shortcuts for common `ls` commands with different options.
alias l='ls -lah'    # List all files in long format, including hidden files, with human-readable sizes.
alias la='ls -lAh'   # List all files in long format, including hidden, but without `.` and `..`.
alias ll='ls -lh'    # List files in long format with human-readable sizes.
alias ls='ls -G'     # Enable colorized output for `ls` (macOS/BSD).
# Override the built-in `history` command with the custom `omz_history` function.
alias history=omz_history

# --- Prompt Configuration ---
# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

	# Exit if not inside a Git repository
	! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

	# Git branch/tag, or name-rev if on detached head
	local GIT_LOCATION=$(git symbolic-ref -q HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD 2>/dev/null)

	local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
	local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
	local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
	local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
	local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
	local STAGED="%{$fg[green]%}●%{$reset_color%}"

	local -a DIVERGENCES
	local -a FLAGS

	# Use `git rev-list --count` which is faster than `log | wc`
	local NUM_AHEAD="$(git rev-list --count @{u}.. 2> /dev/null)"
	if [[ "$NUM_AHEAD" -gt 0 ]]; then
		DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
	fi

	local NUM_BEHIND="$(git rev-list --count ..@{u} 2> /dev/null)"
	if [[ "$NUM_BEHIND" -gt 0 ]]; then
		DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
	fi

	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [[ -n $GIT_DIR && -r $GIT_DIR/MERGE_HEAD ]]; then
		FLAGS+=( "$MERGING" )
	fi

	# Use `git status --porcelain` which is faster than `ls-files` in large repos
	if [[ -n "$(git status --porcelain 2> /dev/null | grep '??')" ]]; then
		FLAGS+=( "$UNTRACKED" )
	fi

	if ! git diff --quiet 2> /dev/null; then
		FLAGS+=( "$MODIFIED" )
	fi

	if ! git diff --cached --quiet 2> /dev/null; then
		FLAGS+=( "$STAGED" )
	fi

	local -a GIT_INFO
	GIT_INFO+=( "%{$fg[white]%}±" )
	GIT_INFO+=( "%{$fg[white]%}${GIT_LOCATION##*\/}%{$reset_color%}" )
	[[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
	[[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
	echo "${(j: :)GIT_INFO}"
}

# Handle pythons virtual env
export VIRTUAL_ENV_DISABLE_PROMPT=1

function py_venv_info() {
	# Return immediately if VIRTUAL_ENV is not set. This ensures no output
	# when a virtual environment is not active.
	[[ -z "$VIRTUAL_ENV" ]] && return

	# Use POSIX-compliant parameter expansion to get the project directory name.
	# This is efficient as it uses shell built-ins, not external commands.
	local parent_dir="${VIRTUAL_ENV%/*}"
	local project_name="${parent_dir##*/}"

	# Echo the project name formatted for the prompt with a trailing space.
	echo "%{$fg[green]%}($project_name)%{$reset_color%} "
}

# Prompt components
PROMPT_SSH='$(ssh_info)'                  # Displays user@host when in an SSH session.
PROMPT_VIRTUAL_ENV='$(py_venv_info)'    # Python Virtual Environment
PROMPT_LOCATION='%{$fg[magenta]%}%~'      # Displays the current directory (~ for home) in magenta,
PROMPT_GIT='$(git_info)'                  # Displays git status information via the git_info function.
PROMPT_STATUS='%(?.%{$fg[blue]%}.%{$fg[red]%})' # Sets the prompt character color: blue for success (exit code 0), red for failure.
PROMPT_CHAR='%(!.#.❯)%{$reset_color%}'     # The prompt character: '#' for root, '❯' for a regular user. Resets color after.

# Use ❯ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1="
${PROMPT_SSH}${PROMPT_VIRTUAL_ENV}${PROMPT_LOCATION} ${PROMPT_GIT}
${PROMPT_STATUS}${PROMPT_CHAR} "
