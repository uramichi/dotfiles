zstyle ':completion:*' menu select=1 completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename "$HOME/.zshrc"
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt auto_menu
autoload -Uz compinit
compinit

# 時刻表示
zmodload zsh/datetime
reset_tmout(){
	TMOUT=$[60-EPOCHSECONDS%60]
}
redraw_tmout(){
	zle reset-prompt
	reset_tmout
}
TRAPALRM(){
	redraw_tmout
}

inform_retval(){
	function(){
		if [ $1 -ne 0 ]; then
			print -P '%F{black}%K{cyan}三(^o^%)ノ['$1']%f%k'
		fi
	} $?
}

precmd_functions=($precmd_functions inform_retval reset_tmout)

HISTFILE=~/.zhistory
HISTSIZE=2000
SAVEHIST=50000
zle_highlight=(default:bold)
WORDCHARS=${WORDCHARS/\//}

bindkey -e
bindkey -r '^M'
bindkey '^[[3~' delete-char

stty stop undef start undef

autoload -U colors
colors
setopt promptsubst
setopt share_history
setopt hist_ignore_dups
setopt correct
setopt autocd
setopt auto_continue
setopt extended_glob
setopt auto_pushd

PROMPT='%B'"$(if [ $UID != 0 ]; then echo -n '%F{magenta}'; else echo -n '%F{red}'; fi)"'%n'"$(if [ "$SSH_CLIENT" != "" ]; then echo -n '@%m'; fi)"' %F{yellow}%1~%F{blue} [%T]%F{cyan}%#%f %f%b'
if [ $SHLVL -ge 2 ]; then
	PROMPT="[$SHLVL]$PROMPT"
fi

alias c++11="clang++ -std=c++11"
alias g++11="g++ -std=gnu++11"
#alias pbcopy="xsel --clipboard --input"
#alias pbpaste="xsel --clipboard"
alias stelnet="openssl s_client -connect"
export COLOR_OPT="auto"
alias ls="ls --color=\$COLOR_OPT"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias grep="grep --color=\$COLOR_OPT"
alias less="less -r"
alias crontab="crontab -i"
alias q=exit
alias 神=vi

# 拡張子: 言語系
alias -s {rb,py,pl,sh}=__run
function __run(){
	if [ -x "$1" ]; then
		"$@"
	else
		case $1 in
			*.rb) ruby   "$@" ;;
			*.py) python "$@" ;;
			*.pl) perl   "$@" ;;
			*.sh) bash   "$@" ;;
		esac
	fi
}

# 拡張子: 解凍する奴
function __extractarchive(){
	case "$1" in
		*.tar.gz|*.tgz ) tar -xzvf  "$1" ;;
		*.tar.xz       ) tar -Jxvf  "$1" ;;
		*.zip          ) unzip      "$1" ;;
		*.lzh          ) lha e      "$1" ;;
		*.tar.bz2|*.tbz) tar -xjvf  "$1" ;;
		*.tar.Z        ) tar -zxvf  "$1" ;;
		*.gz           ) gzip -dc   "$1" ;;
		*.bz2          ) bzip2 -dc  "$1" ;;
		*.Z            ) uncompress "$1" ;;
		*.tar          ) tar -xvf   "$1" ;;
		*.arj          ) unarj      "$1" ;;
		*.rar          ) unrar x    "$1" ;;
	esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,rar}=__extractarchive

# tmuxコマンド
function spl(){
	if [ $1 ]; then
		tmux split-window "($(for arg in "$@"; echo -n ${arg:q}\ )) || (echo EXIT_ERROR; read)"
	else
		tmux split-window
	fi
}
function vs(){
	if [ $1 ]; then
		tmux split-window -h "($(for arg in "$@"; echo -n ${arg:q}\ )) || (echo EXIT_ERROR; read)"
	else
		tmux split-window -h
	fi
}
function tabe(){
	if [ $1 ]; then
		tmux new-window "($(for arg in "$@"; echo -n ${arg:q}\ )) || (echo EXIT_ERROR; read)"
	else
		tmux new-window
	fi
}

function dirsum(){
	(
	cd "$2"
	$1 **/*(.)
	)
}

# ディレクトリハッシュ関数
function dirsum(){
	(
	cd "$2"
	$1 **/*(.)
	)
}

if [ -d ~/.zsh.d ]; then
	for fn in ~/.zsh.d/**/*(.)
		source "$fn"
fi

# vim:ft=zsh
