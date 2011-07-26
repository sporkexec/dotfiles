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
setopt interactive_comments
setopt norm_star_silent
setopt rm_star_wait # 10s is a bit long, though. ^C to bypass.
setopt check_jobs
setopt long_list_jobs
setopt prompt_sp
setopt prompt_subst
setopt c_bases
#setopt function_argzero # sounds good but not sure

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# colors
eval "`dircolors -b`"
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
export BROWSER=chromium

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

# My stuff first because I like to override programs.
export PATH="$HOME/bin:/usr/local/sbin:usr/local/bin:$PATH"

autoload -U colors
colors
for COLOR in red blue green yellow cyan magenta white black; do
	eval $COLOR='%{$fg[$COLOR]%}'
	eval bold$COLOR='%{$fg_bold[$COLOR]%}'
done

function hg_prompt_info {
    hg prompt --angle-brackets "${boldcyan}[<branch>-<rev>] <$blue<status|unknown>><$magenta<status|modified>><$red<update>>" 2>/dev/null
} 

PROMPT=$'$blue%D{%T} $red%n@%m:$boldgreen%~ $(hg_prompt_info)\n$boldcyan%#%{$reset_color%} '
