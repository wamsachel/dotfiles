# Path to your oh-my-zsh installation.
export ZSH=/Users/dietrichwambach/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="gallois"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sublime taskwarrior pip web-search zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/ssl/bin:/usr/local/bin:/usr/local/Cellar/minicom/2.6.2/bin:/usr/X11/bin:/usr/local/MacGPG2/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#alias nmap='noglob nmap'
alias openssl_verify="openssl verify -CAfile"
alias whereami='ifconfig | grep "inet " | cut -d " " -f 2'
alias randpass='openssl rand -base64 32 | pbcopy'
alias lame_randpass='date | md5 | pbcopy'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; say cache flushed'
alias realip='curl -s checkip.dyndns.org | sed -e "s/.*Current IP Address: //" | cut -d"<" -f1'

subnet_var='127.0.0.1'
function local_subnet(){
	subnet_var=`whereami | grep -v -m 1 "^127" | sed 's/\./\*/3' | sed 's/\*.*/\.\*/'`;
	export subnet_var
	echo "Subnet: $my_subnet";
}
export -f local_subnet
local_subnet;  # will ensure the subnet_var gets set

function pingsweep() {
	local_subnet;
	nmap -sP "$subnet_var";
}
export -f pingsweep

function portsweep() {
	local_subnet;
	nmap "$subnet_var" -p $1
}
export -f portsweep

function telnetsweep(){
	portsweep telnet;
}
export -f telnetsweep

function http_sweep(){
	portsweep http;
}
export -f http_sweep

function https_sweep(){
	portsweep https;
}
export -f https_sweep

function sshsweep(){
	portsweep ssh;
}
export -f sshsweep

function der2pem() {openssl x509 -in $1 -inform der;}
export -f der2pem

function der2text() {openssl x509 -in $1 -inform der -noout -text;}
export -f der2text

function p12_2text() {openssl pkcs12 -in $1 -out -noout;}
export -f p12_2text

function serve_file() {nc -l 8008 < $1;}
export -f serve_file

function receive_file() {nc -l 8008 > $1;}
export -f receive_file

export PATH=/usr/local/sbin:$PATH

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
