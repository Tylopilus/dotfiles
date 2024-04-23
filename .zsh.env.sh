#!/bin/zsh

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=vim

#export COMMERCE_ENDPOINT=http://localhost:3002/graphql
#export COMMERCE_ENDPOINT=https://www.b2b-demoshop.de/graphql
export COMMERCE_ENDPOINT=https://luma.comwrap.host/default/graphql
# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Example aliases
alias g='LC_ALL=C git'
alias gh="cd ~/Documents/projects"
alias la="ls -lah"
alias moira="cd ~/Documents/insti\ csvs/moira\ check/"
alias cw="cd ~/Documents/projects/comwrap/repo"
alias fastdeploy="mvn clean install -PautoInstallPackage -DskipTests"
alias clr="clear"
