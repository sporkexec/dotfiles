# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    rxvt) color_prompt=yes;;
    urxvt) color_prompt=yes;;
    screen.rxvt) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[0;31m\]\t \[\033[0;34m\]\u@\h:\[\033[1;32m\]\w
\[\033[1;36m\]\$\[\033[0;0m\] '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
eval "`dircolors -b`"
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

# the "79 column window is too narrow" shit has been driving me crazy
alias w='w|cat'

PATH="$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias vim='vim -p'
export VISUAL=vim
export EDITOR=vim

alias diff=colordiff
alias less='less -R'

remotewebroot='/home/howcoo5/public_html'

alias lhg="ssh -qt live hg -R $remotewebroot"
alias lout="hg out ssh://howcool.com/$remotewebroot"
alias linc="hg inc ssh://howcool.com/$remotewebroot"
alias lpush="hg push ssh://howcool.com/$remotewebroot"

function melvinpush() {
	# Push all changes into melvin's checkouts.
	hg -R /var/www/howcool push /home/melvin/howcool -f -q
	hg -R /var/www/lingerie push /home/melvin/lingerie -f -q
	hg -R /var/www/default push /home/melvin/default -f -q
}

function melvinpull() {
	# Pull all melvin's changes into my checkouts.
	hg -R /var/www/howcool pull /home/melvin/howcool -f -q
	hg -R /var/www/lingerie pull /home/melvin/lingerie -f -q
	hg -R /var/www/default pull /home/melvin/default -f -q
}

defaultpush() {
	# Push from default into other checkouts.
	hg -R /var/www/default push /var/www/howcool -f -q
	hg -R /var/www/default push /var/www/lingerie -f -q
	hg -R /home/melvin/default push /home/melvin/howcool -f -q
	hg -R /home/melvin/default push /home/melvin/lingerie -f -q
}
