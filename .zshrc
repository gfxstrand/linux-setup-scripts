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

#source ${HOME}/projects/crucible/misc/crucible-completion.bash
source ${HOME}/.local/bin/mesa-run-comp.sh

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

    # Hash the host name into a color to use for the command prompt
    host_color=$(hostname | sum | awk -v ncolors=${terminfo[colors]} '{print 1 + ($1 % (ncolors - 1))}')

	# Set the prompt with color
	PS1="%B%F{${host_color}}%n@%m%F{bg-white}%b%# "
	RPS1="%B%F{blue}%~%(0?.. %F{red}(%?%))%b"
	PS2="%B%F{${host_color}}%1_%b%F{bg-white}> "

	# Use color in ls
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	
	# Use color in completions
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	
	# Use color in grep
	export GREP_COLOR='m=01;35'
	alias grep="grep --color"
else
	# Set the prompt without color
	PS1="%n@%m%# "
	RPS1="%~%(0?.. (%?%))"
	PS2="%1_> "
fi

#==============================================================================
# Aliases
#alias vim="vimx"

#==============================================================================
# Environment variables
#export PAGER='less'
export EDITOR='vim'
export VISUAL='vim'

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

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

