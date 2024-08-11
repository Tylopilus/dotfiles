alias c=code
alias clr=clear
alias g='LC_ALL=C git'
alias gh='cd ~/Documents/projects'
alias github=/opt/homebrew/bin/gh
alias gs='git status'
alias la='ls -1ahG'
alias ll='ls -lahG'
alias openai='export OPENAI_API_KEY=$(security find-generic-password -a "$USER" -s 'OPEN_API_KEY' -w)'
alias nvm='fnm'
alias j22='export JAVA_HOME=/usr/local/opt/openjdk@22 ; echo java -version'
alias j11='export JAVA_HOME=/usr/local/opt/openjdk@11 ; echo java -version'
alias vim='export JAVA_HOME=/user/local/opt/openjdk@22;nvim'

# Exports
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.deno/bin:$PATH"
export JAVA_HOME="/usr/local/opt/openjdk@22"
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home"

# Functions
function mkcd() {
  mkdir -p "$1" && cd "$1"
}


# function to get a diff of all tickets of the individual commits
# params are key of the jira ticket, commit to start with, commit to check agains
# sample call: jiraReleaseKeys WEB release-23022024 origin/main
function jiraReleaseKeys() {
  git log --oneline $2..$3 | grep -o "$1-[0-9]*" |  sort | uniq | awk -v ORS=', ' '{ print $1 }' | sed 's/, $/\n/'
}

# function to cd into a directiory and immeadiately run ls -lah
function cx() {
  cd $1 && la
}

# start yazi and cd into the directory after exit
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

_direnv_hook() {
  trap -- '' SIGINT
  eval "$("/opt/homebrew/bin/direnv" export zsh)"
  trap - SIGINT
}
typeset -ag precmd_functions
if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
  precmd_functions=(_direnv_hook $precmd_functions)
fi
typeset -ag chpwd_functions
if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
  chpwd_functions=(_direnv_hook $chpwd_functions)
fi


eval "$(direnv hook zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh --cmd cd)"
