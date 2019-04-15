alias lsusb='system_profiler SPUSBDataType'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH: /usr/local/Cellar/elixir/1.4.2/bin" # Add Elixir to PATH for development
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export GOPATH=$HOME/Code/go

# Set LS Colors
export LSCOLORS=dxfxcxdxbxegedabagacad

# ********** Aliases ********** #
# ***** Navigation ***** #
alias cd..='cd ..'
alias ..='cd ..'
alias ls='ls -G' # regular ls, but with colorized output.
alias la='ls -Glah' # ls with color, long format,  dot files and human readable size.
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
# ***** Bash ***** #
alias ip='ifconfig en0 | grep inet | grep -v inet6 | awk "{print $2}"'
sortByDate() {
  for f in *; do
    dir=$(stat -f%SB -t%Y-%m-%d "$f")
    echo $f '->' $dir
    [ -d "$dir" ] || mkdir "$dir"
    mv "$f" "$dir"/
  done
}
# ***** iTerm ***** #
alias dark='echo "Profile Set to Solarized Dark"; echo -e "\033]50;SetProfile=SolarizedDark\a"'
alias light='echo "Profile Set to Solarized Light"; echo -e "\033]50;SetProfile=SolarizedLight\a"'
function set_iterm_title() {
  if [ $# -eq 0 ]
  then
    echo "0 for 1 parameters";
  elif [ $# -eq 1 ]
  then
    echo -ne "\033]0;$1\007"
  elif [ $# -gt 1 ]
  then
    echo "2 for 1 parameters";
  fi
}
alias title='set_iterm_title'
# ***** powerline ***** #
# . /Users/jack/Code/powerline/powerline/bindings/bash/powerline.sh
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Sends a notification center notification for the current command.
function notify() {
  notification_str="display notification \"Finished Running: $@\" with title \"Notify\""
  $@
  osascript -e "$notification_str"
}

# ***** ssh ***** #
# alias exit='echo "Welcome back"; echo -e "\033]50;SetProfile=Default\a"; exit'
# alias ssh='echo "Welcome to the Danger Zone"; echo -e "\033]50;SetProfile=DangerZone\a"; ssh'
# ***** tmux *****#
alias tmux='tmux -2'
# ***** tmate *****#
alias sshmate='tmate show-messages'
# ***** git ***** #
alias ci='git commit'
alias co='git checkout'
alias gb='git branch'
alias gchanged='git whatchanged --format="%n%C(yellow)commit %H%n%CblueAuthor:      %Creset%an | %ae%n%CblueAuthor Date: %Creset%ad%n%CblueCommit Date: %Creset%cd%n%CblueMessage:%n%Creset%s%n%C(yellow)Changes:"'
alias gdiff='git diff'
alias gdiff-cw='git diff --color-words'
function gl() { git log -n "$@"; } # Calls log for a specific depth
alias glog='git log --color'
alias gpub='if [ `git symbolic-ref --short -q HEAD` = "master" ]; then echo Cannot Publish to Master; else git push origin HEAD:`git symbolic-ref --short -q HEAD` -f -u; fi;' # push the current branch to origin
alias gprune_local='git checkout --quiet master && git branch --merged | grep --invert-match '\\*' | xargs -n 1 git branch --delete; git checkout --quiet @{-1};'
alias git-rename='git config --local user.email "hall.d.jack@gmail.com" ; git config --local user.name "Jack Hall"'
alias gshow='git show'
alias gst='git status'
function branch() {
  read -p "Ticket #: CHOW-" ticket
  read -p "Description: " name

  upper=`echo "CHOW-$ticket" | tr '[:lower:]' '[:upper:]'`
  str="$upper/$name";
  git checkout -b ${str// /-};
}
function simple-branch() {
  str="jh $@";
  git checkout -b ${str// /-};
}
function delete-branch() {
  git branch -D $@; git push origin --delete $@
}
# ***** Tools ***** #
alias ngrok="~/Code/ngrok"
alias tcpd80="sudo tcpdump -s 0 -A -i lo0 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"
alias tcpd3000="sudo tcpdump -s 0 -A -i lo0 'tcp port 3000 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"
watch_func() {
  while :; do clear; $1; sleep $2; done
}
alias watch=watch_func
alias usb_status='system_profiler SPUSBDataType'
alias disk_status='diskutil cs list'
# ***** Bundle ***** #
alias be='bundle exec'
alias bspec='bundle exec rspec'

# ***** Rspec ***** #
function nspec() {
  notify rspec $@
}

# ***** NVM ***** #
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ***** Ember Addons ***** #
function publish-demo() {
  npm run deploy
}
function release-addon() {
  read -p "Version number: " version
  echo 'Release Notes: (ctrl-d to quit)'
  notes=$(</dev/stdin)

  git tag -a "v$version" -m "$notes"
  git push --tags
  npm publish
}
