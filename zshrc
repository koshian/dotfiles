bindkey -e
PATH=$HOME/bin:/usr/games:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:$PATH

PS1=$'%n@%m:%~\n$ '
RPS1=$'%D'


## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

autoload -U compinit && compinit

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
if [ `uname` = 'Darwin' ]; then
  JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
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

### Add rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -r $HOME/.private_zshrc ]; then
  . ~/.private_zshrc
fi

### Add yarn
export PATH="$PATH:`yarn global bin`"

