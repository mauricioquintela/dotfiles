# If you come from bash you might have to change your $PATH.

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mauricioquintela/.oh-my-zsh"
export STEAM_FRAME_FORCE_CLOSE=1
export WP="/home/mauricioquintela/.wallpapers/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13 
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias mv='mv -u'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#alias casa='ssh -Y mauricioquintela@37.189.176.163'
#alias servidor='ssh -p 1337 mauricio@188.83.248.201'
alias grid="ssh -t fc-mfcmquintela@submit.grid.fe.up.pt"
alias lcfpnv='ssh -Y mauricio@10.0.67.167'
alias lcfpl='ssh -Y mauricio@10.0.64.152'
alias cfpl='snx && ssh -Y mauricio@10.0.64.152'
alias cfpnv='snx && ssh -Y mauricio@10.0.67.167'

alias update='yay -Syu --sudoloop && yes | yay -Sc && sudo snap refresh'
#alias update='yay -Syu --sudoloop && yes | yay -Sc && yay -Qqe > Scripts/packages.txt'
#alias clean='yay -Rns $(yay -Qdtq)'
alias ins='yay -S --sudoloop'
#alias uglyx='~/Scripts/update_lyx.sh'
alias uplyx='~/Scripts/upgrade_lyx.sh'
#alias uppoly='~/Scripts/upgrade_polybar.sh'

alias nr='echo RESTARTING NETWORK && sudo systemctl restart networking'
alias sl='ls'
alias :q='exit'
alias stahp='~/HDD/git/stahp'

alias config='vim $(find ~/.config/ranger/* ~/.config/polybar/* ~/.config/qutebrowser/* ~/.config/i3/* -type f | fzf)'
alias cgit='/usr/bin/git --git-dir=/home/mauricioquintela/dotfiles/ --work-tree=/home/mauricioquintela/' 

alias tlpstart='sudo tlpui && sudo tlp start'

alias keygen='/home/mauricioquintela/HDD/git/activator'
alias vp='~/HDD/git/vp.sh'

alias xkcd='sxiv "$(find /HDD/git/xkcd/archive -type f| shuf -n 1)"'
#alias up='. /home/mauricioquintela/Scripts/up.sh'

alias minecraft='__GL_SYNC_TO_VBLANK=0 minecraft-launcher' 

alias proxytor='sudoedit /etc/privoxy/config'

#alias cmatrix='cmatrix -b -s'

#alias 'is_anime_gay?'='echo YES!'

export EDITOR=vim;
export VISUAL=vim;
export NNN_USE_EDITOR=vim



function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bindkey -s '^o' 'ranger-cd\n'


prompt_context() {
  prompt_segment black default "%(!.%{%F{yellow}%}.)"
}
clear
