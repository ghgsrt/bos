# {{{Settings
# zmodload zsh/zprof
# {{{env
export ZLE_RPROMPT_INDENT=0

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/node_modules/.bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if command -v rustup &> /dev/null; then
    export PATH="$HOME/.rustup/toolchains/$(rustup show active-toolchain | grep default | sed 's/ (.*//')/bin:$PATH"
fi
export MANPATH="$HOME/.local/share/man:$MANPATH"
export MANPATH="/usr/local/share/man:$MANPATH"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
if [ -x "$(command -v nvim)" ]; then
    export EDITOR="nvim"
    export PAGER="nvim -c \"BaleiaColorize\" -c \"set nomodifiable\" -c \"set noswapfile\" -c \"nnoremap q q!\""
    #export MANPAGER="vim --cmd 'let g:vim_pager = 1' -c ASMANPAGER -"
fi
export FuzzyFinder="fzf"
if [[ "$(uname)" == "Darwin" ]]; then
    fpath=(/opt/local/share/zsh/site-functions $fpath)
fi
if test -d "$HOME/.zsh_envs.d/"; then
    for _env in "$HOME/.zsh_envs.d/"*; do
        test -r "$_env" && . "$_env"
done
    unset _env
fi
# }}}
# {{{general
set +o nonotify
umask 077
setopt hist_save_no_dups hist_ignore_dups       # eliminate duplicate entries in history
#setopt correctall                               # enable auto correction
setopt autopushd pushdignoredups                # auto push dir into stack and and don’t duplicate them
bindkey -e                                      # emacs mode
# }}}
# {{{prompt
autoload -U promptinit
promptinit
printf "\e[5 q" > $TTY
# }}}
# {{{completion
zcomp_init () {
    # Auto load
    autoload -U +X compinit && compinit
    autoload -U +X bashcompinit && bashcompinit

    # Set options
    setopt MENU_COMPLETE       # press <Tab> one time to select item
    setopt COMPLETEALIASES     # complete alias
    setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
    setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
    setopt PATH_DIRS           # Perform path search even on command names with slashes.
    setopt AUTO_MENU           # Show completion menu on a successive tab press.
    setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
    setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
    setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
    unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

    # Use caching to make completion for commands such as dpkg and apt usable.
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.cache/.zcompcache"

    # Case-insensitive (all), partial-word, and then substring completion.
    if zstyle -t ':prezto:module:completion:*' case-sensitive; then
        zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        setopt CASE_GLOB
    else
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        unsetopt CASE_GLOB
    fi

    # Group matches and describe.
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*:matches' group 'yes'
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
    zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
    zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' verbose yes

    # Fuzzy match mistyped completions.
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric

    # Increase the number of errors based on the length of the typed word. But make
    # sure to cap (at 7) the max-errors to avoid hanging.
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

    # Don't complete unavailable commands.
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

    # Array completion element sorting.
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # Directories
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    # zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
    zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
    zstyle ':completion:*' squeeze-slashes true

    # History
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes

    # Environment Variables
    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # Populate hostname completion. But allow ignoring custom entries from static
    # */etc/hosts* which might be uninteresting.
    zstyle -a ':prezto:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'

    zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
    ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
        ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
            )'

    # Don't complete uninteresting users...
    zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

    # ... unless we really want to.
    zstyle '*' single-ignored show

    # Ignore multiple entries.
    zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
    zstyle ':completion:*:rm:*' file-patterns '*:all-files'

    # auto rehash
    zstyle ':completion:*' rehash true

    #highlight prefix
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")'

    # Kill
    zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:*:kill:*' force-list always
    zstyle ':completion:*:*:kill:*' insert-ids single

    # Man
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # Media Players
    zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
    zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
    zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
    zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

    # Mutt
    if [[ -s "$HOME/.mutt/aliases" ]]; then
        zstyle ':completion:*:*:mutt:*' menu yes select
        zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
    fi

    # SSH/SCP/RSYNC
    zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
    zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
    zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
}
# }}}
# {{{rtv
#export RTV_EDITOR="vim"
#export RTV_BROWSER="w3m"
#export RTV_URLVIEWER="urlscan"
# }}}
# }}}
# {{{Functions
test_cmd_pre() { # {{{
    command -v "$1" >/dev/null
} # }}}
test_cmd() { # {{{
    test_cmd_pre "$1" && echo 'yes' || echo 'no'
} # }}}
# {{{FuzzyFinder
# fuzzy match dirs and cd
cdf() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | "$FuzzyFinder") &&
        cd "$dir"
    }
    # include hidden dirs
    cdf-all() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | grep -v ".git/" | "$FuzzyFinder") && cd "$dir"
}
# job to fore
job-fore() {
JOB_ID=$(jobs | grep "[[[:digit:]]*]" | "$FuzzyFinder" | grep -o "[[[:digit:]]*]" | grep -o "[[:digit:]]*")
fg %"$JOB_ID"
}

# job to back
job-back() {
JOB_ID=$(jobs | grep "[[[:digit:]]*]" | "$FuzzyFinder" | grep -o "[[[:digit:]]*]" | grep -o "[[:digit:]]*")
bg %"$JOB_ID"
}

# job kill
job-kill() {
JOB_ID=$(jobs | grep "[[[:digit:]]*]" | "$FuzzyFinder" | grep -o "[[[:digit:]]*]" | grep -o "[[:digit:]]*")
kill %"$JOB_ID"
}
# }}}
install-fzf() { # {{{
_architecture=""
case "$(uname -m)" in
    i386)     _architecture="x86" ;;
    i686)     _architecture="x86" ;;
    x86_64)   _architecture="amd64" ;;
    *)        _architecture="$(uname -m)" ;;
esac
_download_url=$(
curl -sL https://api.github.com/repos/junegunn/fzf/releases/latest |\
    grep -e 'https://github.com.*zip' -e 'https://github.com.*tar.gz' |\
    sed -e 's/.*https/https/' -e 's/".*$//' |\
    grep -i "$(uname)" |\
    grep "${_architecture}"
)
mkdir -p ~/.local/bin
if command -v proxychains4 &> /dev/null; then
    proxychains4 -q curl -L "${_download_url}" |\
        tar zxv -C ~/.local/bin
        else
            curl -L "${_download_url}" |\
                tar zxv -C ~/.local/bin
fi
chmod a+x ~/.local/bin/fzf
unset _download_url _architecture
} # }}}
uninstall-fzf() { # {{{
rm -f ~/.local/bin/fzf
} # }}}
install-bash-it() { # {{{
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh
} # }}}
cargo-update() { # {{{
if [ -x "$(command -v cargo-install-update)" ]; then
    cargo install-update -a
else
    cargo install $(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
fi
} # }}}
compeval() { # {{{
    [ -x "$(command -v pnpm)" ] && source <(pnpm completion zsh) || echo "pnpm not found"
    [ -x "$(command -v ng)" ] && source <(ng completion script) || echo "ng not found"
} # }}}
#pacclean() { # {{{
#    sudo paccache -rf -k 0
#    pacman -Qdtq | sudo pacman -Rns -
#    /usr/bin/ls -d -1 "$HOME/.cache/pikaur/build/"* | grep -v '.*git\>' | xargs sudo rm -rf
#    /usr/bin/ls -d -1 "$HOME/.local/share/pikaur/aur_repos/"* | grep -v '.*git\>' | xargs sudo rm -rf
#    rm -rf ~/.cache/pikaur/pkg
#    sync
#}
should_sudo() {
    if [ "$USER" = "root" ]; then
        $@
        return
    fi

        # Check if user is in wheel group
        if groups "$USER" | grep -q "\bwheel\b"; then
            sudo "$@"
        fi
    } 

    gpg_export() {
        gpg --export-secret-keys -a "$1" > "$2".asc
    }
    # }}}
    # }}}

## {{{
alias gpghelp='echo gpggen -> gpglist -> pass the string after the first / in sec to gpgexport; second line in sec is signing key for .gitconfig'
alias gpggen='gpg --full-generate-key'
alias gpglist='gpg --list-secret-keys --keyid-format=long'
alias gpgexport='gpg --armor --export'

alias fuckgpg='echo UPDATESTARTUPTTY | gpg-connect-agent'

alias ssh_new_key='ssh-keygen -t ed25519 -C "$BOS_EMAIL"'

alias nconnect='sudo nmcli d wifi rescan; sudo nmcli d wifi connect --ask'

alias tmuxinstall='$BOS_HOME_PROFILE/share/.tmux/plugins/tpm/scripts/install_plugins.sh'

alias ls='should_sudo ls -CF --color=auto'
alias la='ls -A'  # show all
alias ll='ls -l'  # list format
alias Ls='ls -L'  # follow symlinks
alias La='la -L'  # follow symlinks (all)
alias Ll='ll -L'  # follow symlinks (list)
alias lla='la -l' # list format (all)
alias Lla='lla -L' # follow symlinks (all,list)
alias lt='ls -t'  # sort by time
alias lu='ls -u'  # sort by last access
alias lss='ls -s' # show size

export BAT_THEME=ansi
alias cat='bat --paging=never'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias n='nvim'

alias q='exit'
alias c='clear'
alias h='history'

export PAGER='less -R --color=auto'
alias du='du -sh'
alias df='df -h'
alias cp='cp -p'
alias mkdir='mkdir -p'
alias cdh='pushd +$( dirs -v | "$FuzzyFinder" | grep -o "[[:digit:]]") > /dev/null'
alias cdh-ls='dirs -vl | "$FuzzyFinder"'
alias cdh-clean='popd +$( dirs -v | "$FuzzyFinder" | grep -o "[[:digit:]]") > /dev/null'
alias cdh-clean-all='dirs -c'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias nnn='PAGER= nnn'
alias pager="${PAGER}"
alias help='$BOS_DOTFILES_DIR/scripts/help.sh'
alias tmuxinit='$BOS_DOTFILES_DIR/scripts/tmuxinit.sh'
alias gencomp-help='gencomp'
alias rga="rg --hidden --ignore-vcs '--glob=!.git/*'"
if [ -x "$(command -v lsd)" ]; then
    alias ls='lsd'
    alias tree='lsd --tree'
elif [ -x "$(command -v exa)" ]; then
    alias ls='exa'
    alias tree='exa --tree'
fi
if [[ "$(uname)" == "Linux" ]]; then
    alias open="xdg-open".
fi

# }}}
# {{{Plugins
# https://github.com/zdharma-continuum/zinit
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview
# https://github.com/sorin-ionescu/prezto

#. <(COMPLETE=zsh tms)

[ ! -f "$HOME/.zinit/bin/zinit.zsh" ] && mkdir -p ~/.zinit && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
PURE_POWER_MODE=modern
zinit ice atload"source $HOME/.zsh-theme/.p10k.zsh"
zinit light romkatv/powerlevel10k
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'0' lucid depth=1; zinit light zsh-users/zsh-history-substring-search
zinit ice wait'1' lucid depth=1; zinit light ytet5uy4/fzf-widgets
zinit ice wait'0' lucid depth=1; zinit light urbainvaes/fzf-marks
zinit ice wait'1' lucid depth=1; zinit light hlissner/zsh-autopair
zinit ice wait'0' lucid depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice wait'1' lucid depth=1 \
    atload"zcomp_init" \
    atpull"zinit cclear && zinit creinstall sainnhe/zsh-completions"
    zinit light sainnhe/zsh-completions
    zinit snippet "https://testingcf.jsdelivr.net/gh/ohmyzsh/ohmyzsh@master/plugins/dotenv/dotenv.plugin.zsh"
    zinit ice pick"pfetch" as"program"; zinit snippet "https://testingcf.jsdelivr.net/gh/dylanaraps/pfetch@master/pfetch"
    zinit ice pick"neofetch" as"program"; zinit snippet "https://testingcf.jsdelivr.net/gh/dylanaraps/neofetch@master/neofetch"
    zinit ice pick"sysz" as"program"; zinit snippet "https://testingcf.jsdelivr.net/gh/joehillen/sysz@master/sysz"
    zinit ice mv"httpstat.sh -> httpstat" \
        pick"httpstat" as"program"
            zinit snippet "https://testingcf.jsdelivr.net/gh/b4b4r07/httpstat@master/httpstat.sh"
            zinit ice wait'1' lucid ver=v0.15.0 \
                as"program" \
                pick"bin/asdf"
                            zinit light asdf-vm/asdf
                            zinit ice wait'1' lucid depth=1 \
                                as"program" \
                                pick"bin/*" \
                                atload"export MANPATH=$HOME/.zinit/plugins/sunaku---dasht/man:$MANPATH && source etc/zsh/completions.zsh"
                                                            zinit light sunaku/dasht
                                                            zinit ice pick"pb" as"program"; zinit snippet "https://testingcf.jsdelivr.net/gh/SharzyL/pastebin-worker@goshujin/scripts/pb"
                                                            zinit ice pick"_pb" as"completion"; zinit snippet "https://testingcf.jsdelivr.net/gh/SharzyL/pastebin-worker@goshujin/scripts/_pb"
                                                            # {{{fast-syntax-highlighting
                                                            FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"
                                                            # }}}
                                                            # {{{fzf
                                                            # $ fzf                 # fuzzy search files
                                                            # Tab/Down/S-Tab/Up     # navigate
                                                            # C-s                   # Select items
                                                            # C-p                   # Toggle preview
                                                            export FZF_DEFAULT_COMMAND='fd . --type=file --hidden'
                                                            export FZF_DEFAULT_OPTS="
                                                            --multi
                                                            --height=50%
                                                            --layout=reverse
                                                            --prompt='❯ '
                                                            --pointer='>'
                                                            --marker='+'
                                                            --ansi
                                                            --color=dark
                                                            --preview \"bat --theme=ansi --color=always --style=numbers --line-range=:500 {}\"
                                                            --tabstop=4
                                                            --color=hl:3:bold,fg+:green:bold,bg+:-1,hl+:3:bold,info:3:bold,border:11,prompt:2,pointer:5,marker:1,header:6
                                                            --bind=tab:down,btab:up,ctrl-s:toggle,ctrl-p:toggle-preview
                                                            --separator=
                                                            "

# C-f fzf-widgets
# C-r history search
# **<Tab> fuzzy matching path
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
bindkey '^F'  fzf-select-widget
bindkey '^R'  fzf-insert-history
bindkey -r "^[c"
bindkey -r "^T"
# }}}
# {{{fzf-marks
# Usage:
# $ mark        # mark current directory
# $ fzm         # select marked directories using fzf
# ^z            # select marked directories using fzf
# ^d            # delete selected items when in fzf
FZF_MARKS_FILE="$HOME/.cache/fzf-marks"
FZF_MARKS_COMMAND="fzf"
FZF_MARKS_COLOR_RHS="249"
FZF_MARKS_JUMP="^z"
# }}}
# {{{zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
bindkey '^[z' autosuggest-execute
bindkey '^[x' autosuggest-execute
# }}}
# {{{zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}}
# {{{pfetch
export PF_COL1=2
export PF_COL3=3
# }}}
# {{{asdf
export PATH="$HOME/.asdf/shims:$PATH"
# }}}
# {{{pb
export PB_DOMAIN="share.sainnhe.dev"
# }}}
# }}}
# {{{Startup
# zprof  # 取消注释首行和本行，然后执行 time zsh -i -c exit
# 若直接执行 zprof，将会测试包括 lazyload 在内的所有启动时间
# }}}
# vim: set fdm=marker fmr={{{,}}}:

export ZVM_INIT_MODE=sourcing
source /etc/bos/bashrc
eval "$(zoxide init --cmd cd zsh)"


function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions


[ ! -d "$HOME/.git-subrepo" ] && git clone https://github.com/ingydotnet/git-subrepo "$HOME/.git-subrepo"
source "$HOME/.git-subrepo/.rc"

[ -d "$HOME/.config/spotifyd/scripts/autoload" ] &&
if test -d "$HOME/.config/spotifyd/scripts/autoload"; then
    for _script in "$HOME/.config/spotifyd/scripts/autoload"*; do
        test -r "$_script" && . "$_script"
    done
    unset _script
fi

