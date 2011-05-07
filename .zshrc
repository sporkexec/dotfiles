setopt vi # Gotta fix key bindings after this.
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End

setopt auto_cd
setopt noauto_name_dirs
setopt extended_glob
setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt interactive_comments
setopt norm_star_silent
setopt rm_star_wait # 10s is a bit long, though. ^C to bypass.
setopt check_jobs
setopt long_list_jobs
setopt prompt_sp
setopt prompt_subst
setopt c_bases
#setopt function_argzero # sounds good but not sure

# enable color support of ls and also add handy aliases
eval "`dircolors -b`"
alias ls='ls --color=auto'

# grep variants
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# the "79 column window is too narrow" shit has been driving me crazy
alias w='w|cat'

# we use vim and we use tabs. always.
alias vim='vim -p'
export VISUAL=vim
export EDITOR=vim

export BROWSER=chromium

# pretty diff output
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

PATH="$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin"

function hg_prompt_info {
    hg prompt --angle-brackets $'%{\033[1;36m%}[<branch>-<rev>] <%{\033[1;34m%}<status|unknown>><%{\033[1;35m%}<status|modified>><%{\033[1;31m%}<update>>' 2>/dev/null
} 

PROMPT=$'%{\033[0;34m%}%D{%T} %{\033[0;31m%}%n@%m:%{\033[1;32m%}%~%{\033[0;34m%} $(hg_prompt_info)\n%{\033[1;36m%}%#%{\033[0;0m%} '
