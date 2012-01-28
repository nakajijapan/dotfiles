# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac

########################################
## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    #PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    #PROMPT="%{${fg[cyan]}%}$(echo "root" | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT="%{${fg[red]}%}%B[%n] #%{${reset_color}%}%b"
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    #PROMPT="%{${fg[red]}%}[%/%%]%{${reset_color}%} "
    #PROMPT="%{${fg[red]}%}%B[%n %T] %1/#%{${reset_color}%}%b "
    PROMPT="%{${fg[red]}%}%B[%n] #%{${reset_color}%}%b "
    RPROMPT="[%~]"
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

########################################
# auto change directory
#
setopt auto_cd

########################################
# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

########################################
# command correct edition before each completion attempt
#
setopt correct

########################################
# compacked complete list display
#
setopt list_packed

########################################
# no remove postfix slash of command line
#
setopt noautoremoveslash

########################################
# no beep sound when complete list displayed
#
setopt nolistbeep

########################################
## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

########################################
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
#bindkey "^p" history-beginning-search-backward-end
#bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history      # 履歴ファイルに開始時刻と経過時間を記録
setopt append_history        # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_ignore_dups      # ignore duplication command history list

## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias lla="ls -al"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"


alias du="du -h"
alias df="df -h"

alias su="su -l"
alias xemacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

alias e="emacs"

# rails
alias r="rails"
alias rr="rake routes | less"
alias rd="rails destroy"
alias rspec='rspec -c'
alias rdm='rake db:migrate'

# git
alias g="git"
alias gs="git status"
alias ci="git commit"
alias cia="git commit --amend"
alias gl="git pull --rebase"
alias pus="git push"
alias c="git checkout"
alias b='git branch'
alias f='git flow'
alias ff='git flow feature'
alias ffs='git flow feature start'
alias fff='git flow feature finish'
alias fr='git flow release'
alias frs='git flow release start'
alias frf='git flow release finish'
alias gw='git wtf'
alias gc='git clone --recursive'

case "${TERM}" in
screen|screen-256color)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

## NakajiJapan Setting
#
#
#export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
export PATH=/usr/local/bin:/usr/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH

# Editor
export EDITOR=emacs

#色の定義
local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
local GREEN=$'%{^[[1;32m%}'$
local YELLOW=$'%{^[[1;33m%}'$
local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$
local BOLD_BEGIN=$'%B'$
local BOLD_END=$'%b'$

# 補完に関するオプション
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
#setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
#setopt list_types           # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
#setopt auto_menu            # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
#setopt auto_name_dirs
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示

#setopt print_eight_bit      #日本語ファイル名等8ビットを通す
#setopt extended_glob        # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
#setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ

# 十字キーで保管を移動できる
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を過剰にしてみる
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
#zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate
zstyle ':completion:*:messages' format $YELLOW'%B%d%b'$DEFAULT
#
#zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:warnings' format "%{${fg[white]}%}No mathes for %d%{${reset_color}%}" 
#zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:descriptions' format "%{${fg[black]}${bg[blue]}%}completing %B%d%b%{${reset_color}%}"
#zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
#zstyle ':completion:*:options' description 'yes'

#-------------------------------------------------------
# function
#-------------------------------------------------------
## history
#
function hisall { history -E 1 } # 全履歴の一覧を出力する
alias his="history"

## create new window and rename session to hostname
#
if [ $TERM = xterm ]; then
    function ssh_tmux() {
        eval server=\${$#}
        cmd='exec ssh '$@
        #echo "$server" "ssh $@"
        #tmux new-window -n $server "ssh $@"
        tmux new-window -n $server $cmd
        #tmux rename-session $server
        #ssh $@
        echo $cmd
    }
    alias ssh=ssh_tmux
fi

## cdを打ったら自動的にlsを打ってくれる関数
#
function cd(){
    builtin cd $@ && ls;
}
