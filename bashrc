alias lsusb='system_profiler SPUSBDataType'

export DOTFILES_PATH="$HOME/Code/dotfiles"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH: /usr/local/Cellar/elixir/1.4.2/bin" # Add Elixir to PATH for development
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export GOPATH=$HOME/Code/go
source $DOTFILES_PATH/corberrc

# Set LS Colors
export LSCOLORS=dxfxcxdxbxegedabagacad

# ********** Aliases ********** #
# ***** Navigation ***** #
alias cd..='cd ..'
alias ..='cd ..'
alias ls='ls -G' # regular ls, but with colorized output.
alias la='ls -Glah' # ls with color, long format,  dot files and human readable size.
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
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
alias dark='change_profile Solarized Dark;'
alias light='change_profile Solarized Light;'
change_profile () {
  NAME=$1;
  echo "Profile Set to $NAME"
  echo -e "\033]50;SetProfile=$NAME\a"
}
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
alias git-rename='git config --local user.email "hall.d.jack@gmail.com" ; git config --local user.name "Jack Hall"'
alias glog='git log --color'
alias gpub='if [ `git symbolic-ref --short -q HEAD` = "master" ]; then echo Cannot Publish to Master; else git push origin HEAD:`git symbolic-ref --short -q HEAD` -f -u; fi;' # push the current branch to origin
alias gprune_local='git checkout --quiet master && git branch --merged | grep --invert-match "\*" | xargs -n 1 git branch --delete; git checkout --quiet @{-1};'
alias gr-master='git checkout --quiet master && git pull --quiet && git checkout --quiet - && git rebase master;'
alias grep='grep --color -rn'
alias gshow='git show'
alias gst='git status -u'
function branch() {
  read -p "Ticket #: " ticket
  read -p "Description: " name

  upper=`echo "$ticket" | tr '[:lower:]' '[:upper:]'`
  str="$upper/$name";
  git checkout -b ${str// /-};
}
function delete-branch() {
  git branch -D $@; git push origin --delete $@
}
function gl() { git log -n "$@"; } # Calls log for a specific depth
function simple-branch() {
  str="jh $@";
  git checkout -b ${str// /-};
}
function co-remote() {
  fullBranch=$@;
  remote=$(echo $fullBranch | sed 's/\([^\/]*\)\/.*/\1/g');
  branchName=$(echo $fullBranch | sed 's/[^\/]*\/\(.*\)/\1/g');

  git checkout -b $branchName $fullBranch
}
function fixup() {
  SAVEIFS=$IFS;
  IFS=$'\n';
  commits=(`git log --pretty=format:'%h %s (%cr) <%an>' --abbrev-commit master...`);
  # We might be able to avoid changing $IFS if we use xargs to split the result of git log by newline. git log ... | xargs -n 1 echo.
  IFS=$SAVEIFS;

  printf "\e[48;5;240mCommits on this branch:\e[K\n";
  for (( i=0; i<${#commits[@]}; i++ ))
  do
    if ! (( $i % 2 == 0 )); then
      style-commit $i "${commits[$i]}" true
    else
      style-commit $i "${commits[$i]}" false
    fi
  done

  printf "\e[48;5;240mChoose a commit to fix up.\e[K\n";
  read choice

  commit=${commits[$choice]}
  commitArray=($commit)

  sha=${commitArray[0]}

  printf "\e[48;5;240mRunning: \e[38;5;208git commit --fixup $sha\e[K\n";
  git commit --fixup $sha
  printf "\e[48;5;240mRunning: \e[38;5;208git rebase --autosquash $sha~2\e[K\n";
  git rebase --autosquash $sha~2

  printf "Fixup Complete\e[0m\n";
}
function style-commit() {
  # http://www.andrewnoske.com/wiki/Bash_-_adding_color
  # https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
  index=$1
  highlight=$3
  commitArray=($2)
  sha=${commitArray[0]}
  unset commitArray[0]

  if [ $highlight == true ]; then
    printf "\e[48;5;240m  \e[48;5;241m\e[38;5;083m$index: \e[38;5;220m$sha \e[0m\e[48;5;241m${commitArray[*]}\e[48;5;240m  \e[K\n"
  else
    printf "\e[48;5;240m  \e[38;5;083m$index: \e[38;5;220m$sha \e[0m\e[48;5;240m${commitArray[*]}  \e[K\n"
  fi
}
function change-branch() {
  branches=(`git branch | sed 's/\*//g' | xargs -n 1 echo`)

  printf "\e[48;5;240mBranches:\e[K\n";
  for (( i=0; i<${#branches[@]}; i++ ))
  do
    if ! (( $i % 2 == 0 )); then
      style-branch $i "${branches[$i]}" true
    else
      style-branch $i "${branches[$i]}" false
    fi
  done

  printf "\e[48;5;240mChoose a branch to switch to.\e[K\n";
  read choice

  branch=${branches[$choice]}
  printf "\e[48;5;240mRunning: \e[38;5;208git checkout $branch\e[K\n";
  git checkout $branch

  printf "Complete\e[0m\n";
}
function style-branch() {
  # http://www.andrewnoske.com/wiki/Bash_-_adding_color
  # https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
  index=$1
  branch=$2
  highlight=$3

  if [ $highlight == true ]; then
    printf "\e[48;5;240m  \e[48;5;241m\e[38;5;083m$index: \e[0m\e[48;5;239m$branch\e[48;5;240m  \e[K\n"
  else
    printf "\e[48;5;240m  \e[38;5;083m$index: \e[0m\e[48;5;240m$branch  \e[K\n"
  fi
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
function colors() {
  for((i=16; i<256; i++)); do
    printf "\e[48;5;${i}m%03d" $i;
    printf '\e[0m';
    [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
  done
}
# ***** Rspec ***** #
function nspec() {
  notify rspec $@
}
alias cspec='nspec $(gst -su | grep "_spec.rb" | sed "s/.* \(.*_spec.rb\)/\1/g")'

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
