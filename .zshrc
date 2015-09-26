# Vim Mode
bindkey -v

#==============================================================================
# ZSH Variables

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Don't check the mail
MAILCHECK=0

# Directory stack
DIRSTACKSIZE=10

#==============================================================================
# Completion
autoload -Uz compinit bashcompinit
compinit
bashcompinit

source ${HOME}/projects/crucible/misc/crucible-completion.bash

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Don't match .svn files/directories
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/).svn'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#.svn'

#==============================================================================
# Print the current user, host, and path in the title bar of the terminal
# emulator window
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]1;%n@%m: %~\e\\"
            ;;
        *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%n@%m: %~\a"
            ;;
    esac
}
chpwd

#==============================================================================
# Set color usage
autoload -U colors
autoload -U zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors

	# Set the prompt with color
	PS1="%B%{${fg[green]}%}%n@%m%{${fg[white]}%}%b%# "
	RPS1="%B%{${fg[blue]}%}%~%(0?.. %{${fg[red]}%}(%?%))%b"
	PS2="%B%{${fg[green]}%}%1_%b%{${fg[white]}%}> "

	# Use color in ls
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	
	# Use color in completions
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	
	# Use color in grep
	export GREP_COLOR='01;35'
	alias grep="grep --color"
else
	# Set the prompt without color
	PS1="%n@%m%# "
	RPS1="%~%(0?.. (%?%))"
	PS2="%1_> "
fi

#==============================================================================
# Aliases
alias vim="vimx"

#==============================================================================
# Environment variables
#export PAGER='less'
export EDITOR='vim'
export VISUAL='vim'

export PATH="/home/jason/.local/bin:$PATH"

#==============================================================================
# Stuff for Android Development
android-env() {
    export PATH="$PATH:$HOME/.local/android-sdk-linux/tools:$HOME/.local/android-sdk-linux/platform-tools:$HOME/.local/android-ndk-r8b"
}

#==============================================================================
# Stuff for Wayland Development
wayland-env() {
    export WLD=$HOME/.local/wayland
    export LD_LIBRARY_PATH=$WLD/lib
    export PKG_CONFIG_PATH=$WLD/lib/pkgconfig:$WLD/share/pkgconfig
    export ACLOCAL="aclocal -I $WLD/share/aclocal"
    export PATH=$WLD/bin:$PATH
}

export USE_CCACHE=1
export CCACHE_DIR="${HOME}/.ccache"

