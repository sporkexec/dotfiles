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
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

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
. ~/scripts/base16-monokai.dark.sh
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
export PATH="$HOME/bin:/usr/local/sbin:usr/local/bin:$PATH"
export PYTHONPATH="$HOME/lib/python:$PYTHONPATH"

autoload -U colors
colors
for COLOR in red blue green yellow cyan magenta white black; do
	eval $COLOR='%{$fg[$COLOR]%}'
	eval bold$COLOR='%{$fg_bold[$COLOR]%}'
done

PROMPT=$'$blue%D{%T} $red%n@%m:$boldgreen%~\n$boldcyan%#%{$reset_color%} '
