autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=2048
SAVEHIST=2048
setopt inc_append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space

setopt vi # Gotta fix key bindings after this.
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey '^[[2~' overwrite-mode

setopt auto_cd
setopt noauto_name_dirs
setopt extended_glob
setopt interactive_comments
setopt norm_star_silent
setopt check_jobs
setopt long_list_jobs
setopt prompt_sp
setopt prompt_subst
setopt c_bases

# quick shortcuts up
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# colors
. ~/bin/base16-monokai.dark.sh
eval "`dircolors -b ~/.dir_colors`"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff=colordiff

#alias less='less -FRSX'
# F = exit on small files
# R = allow color/terminal escapes
# S = don't wrap lines
# X = don't fuck around with the terminal, eg. -F is weird without it

# the "79 column window is too narrow" shit has been driving me crazy
alias w='w|cat'

# we use vim and we use tabs. always.
alias vim='vim -p'
export VISUAL=vim
export EDITOR=vim
export PAGER=less
export BROWSER=google-chrome-unstable

# My stuff first because I like to override programs.
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export PYTHONPATH="$HOME/lib/python:$PYTHONPATH"

# Let bspwm reuse window arrangement on restart
export BSPWM_TREE=/tmp/bspwm.tree
export BSPWM_HISTORY=/tmp/bspwm.history
export BSPWM_STACK=/tmp/bspwm.stack

autoload -U colors
colors
for COLOR in red blue green yellow cyan magenta white black; do
	eval $COLOR='%{$fg[$COLOR]%}'
	eval bold$COLOR='%{$fg_bold[$COLOR]%}'
done

PROMPT=$'$blue%D{%T} $red%n@%m:$boldgreen%~\n$boldcyan%#%{$reset_color%} '
