# -*- encoding: utf-8 -*- 
bindkey -e
PATH=$HOME/bin:/usr/games:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:$PATH

if [ `uname` = 'Darwin' ]; then
    ICON=`echo -n '\uf179'`
elif [ `uname` = 'Linux' ]; then
    ICON=`echo -n '\uf17c'`
elif [ -n "`cat /proc/version | grep Microsoft`" ]; then
    ICON=`echo -n '\uf17a'`
else
    ICON=`echo -n '\uf108'`
fi

PS1=`echo -en "%n@%m:${ICON}:%~\n$ "`
RPS1=$'%D{%a %b %d %Y}'

## predict
# autoload predict-on
# predict-on

## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

autoload -U compinit && compinit
autoload -Uz add-zsh-hook

# options
setopt BASH_AUTO_LIST
setopt LIST_AMBIGUOUS
setopt AUTO_PUSHD

## history
HISTFILE="$HOME/.zhistory"
HISTSIZE=65536
SAVEHIST=65536
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

# google
function google() {
  local str opt 
    if [ $# != 0 ]; then # 引数が存在すれば
        for i in $*; do
              str="$str+$i"
        done    
        str=`echo $str | sed 's/^\+//'` #先頭の「+」を削除
        opt='search?num=50&hl=ja&ie=utf-8&oe=utf-8&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.com/$opt #引数がなければ $opt は空になる
    # mozilla -remote openURL\(http::/www.google.com/$opt\) # 未テスト
}
alias ggl=google

# backup file
function mvdate() {
  mv $1 $1.`date +%Y%m%d_%H%M%S`
}

# enveronment variables
export EDITOR=vi
export LANG=C
export DLANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_MESSAGES=C
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=SCIM
export QT_IM_MODULE=SCIM
export MADOKADIR=~/.madoka/
export DEBFULLNAME='Sugano "Koshian" Yoshihisa(E)'
export DEBEMAIL='koshian@foxking.org'
export NEWSSPOOL="$HOME/News"
export SCSI_BUS=0
export SCSI_ID=0
export SCSI_LUN=0
export PAGER=lv
export CVS_RSH=ssh
export CVSROOT=$HOME/var/cvs
export TORSOCKS_CONF_FILE=$HOME/etc/torsocks.conf

if [ `uname` = 'Darwin' ]; then
  unset JAVA_HOME
  #JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
else
  JAVA_HOME=/usr/lib/j2sdk1.5-sun
fi
export JAVA_HOME

export G_FILENAME_ENCODING=UTF-8
export CMAPINPUTS=".:/usr/share/fonts/cmap/adobe-japan1//:/usr/share/fonts/cmap/adobe-japan2//:/usr/share/fonts/cmap/adobe-gb1//:/usr/share/fonts/cmap/adobe-cns1//:/usr/share/fonts/cmap/gs-cjk-resource//"
export CONCURRENCY_LEVEL=6
export DBIC_TRACE="1=/tmp/trace.out"

# for git
#export GIT_AUTHOR_NAME='Sugano Yoshihisa(E)'
#export GIT_AUTHOR_EMAIL='koshian@foxking.org'
#export GIT_COMMITTER_NAME='Sugano Yoshihisa(E)'
#export GIT_COMMITTER_EMAIL='koshian@foxking.org'

# aliases
alias xemacs='LC_ALL=C LANG=C XMODIFIERS= xemacs'
#alias less=jless
alias xfontsel='xfontsel -scaled'
alias aterm='aterm -fg white -bg black -sh 50% -tr'
alias xmascot="xmascot -soundcmd 'esdplay %s'"
#RR_OPT='-r -input-charset=euc-jp -output-charset=euc-jp'
#APLLE_OPT='-apple -input-hfs-charset=euc-jp -output-hfs-charset=sjis'
#APLLE_OPT='-apple -output-hfs-charset=sjis'
MKISOFS_OPT="$RR_OPT $APPLE_OPT -J -joliet-long"
alias mkisofs="mkisofs $MKISOFS_OPT"
alias eng='export LANG=C; export LC_ALL=C'
alias ja="export LANG=$DLANG; export LC_ALL=$DLANG"
alias ls='/bin/ls'
alias make-kpkg="LC_ALL=C; make-kpkg"
alias passwd-gen='cmd=`which mmencode || which mimencode`; head -c 6 /dev/urandom | $cmd'
alias fd='TERM=vt100 fd'
alias unlha='lha -x'
alias dpms='xset dpms 1800 3600 4000'
alias xautolock='xautolock -time 15 -cornerdelay 10'
alias joy2key-ines='joy2key -rcfile ~/.joy2keyrc -config ines'
alias joy2key='joy2key -rcfile ~/.joy2keyrc -config'
alias a2ps='a2psj -a4 -nh -nt -ns'
alias rdesktop='rdesktop -a 24 -r sound:local -g 1600x1200'

# time format
TIME='\nreal %e\nuser %U\nsys %S'; export TIME
alias time=/usr/bin/time

# keychain
if [ `uname` != 'Darwin' ]; then
  keychain
  . ~/.keychain/`hostname`-sh
fi

if [ -r $HOME/.private_zshrc ]; then
  . ~/.private_zshrc
fi

### Add yarn
if [ -x "`which yarn`" ]; then
  export PATH="$PATH:`yarn global bin`"
fi

### terminal notifier
export SYS_NOTIFIER=`which terminal-notifier`
export NOTIFIER_COMMNAND_TIMEOUT=10
NOTIFY_PLUGIN=$HOME/src/zsh-notify/notify.plugin.zsh
if [ -r $NOTIFY_PLUGIN ]; then
  . $NOTIFY_PLUGIN
fi 

### MacTeX
if [ -e /usr/texbin ]; then
  export PATH=/usr/texbin:"$PATH"
fi


### Use Brewed OpenSSL
OPENSSL_PATH=/usr/local/opt/openssl
if [ -d "$OPENSSL_PATH" ];then
  export PATH=$OPENSSL_PATH/bin:$PATH
  export LD_LIBRARY_PATH=$OPENSSL_PATH/lib:$LD_LIBRARY_PATH
  export CPATH=$OPENSSL_PATH/include:$LD_LIBRARY_PATH
fi

### rbenv
if [ -x "`which rbenv`" ]; then
  eval "$(rbenv init -)"
fi

### Use go
export GOPATH=$HOME/var/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

### swiftenv
#export SWIFTENV_ROOT="$HOME/.swiftenv"
#export PATH="$SWIFTENV_ROOT/bin:$PATH"
#eval "$(swiftenv init -)"

### PostgreSQL libraries on HomeBrew
if [ `uname` = 'Darwin' ]; then
  export PATH="/usr/local/opt/icu4c/bin:$PATH"
  export PATH="/usr/local/opt/icu4c/sbin:$PATH"
  export LDFLAGS="${LDFLAGS} -L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/icu4c/include"
fi

### composer
if [ -n `which composer` ]; then
  export PATH="${HOME}/.composer/vendor/bin:$PATH"
fi

### aws-cli
if [ -n `which aws` ]; then
  . `which aws_zsh_completer.sh`
fi


