# dotfiles
Dotfiles for tmux, vim and bash including powerline for all.

## Setup
1. Clone the repo.
2. Load the iTerm2 settings

  ```
  Preferences > General > "Load preferences from a customer folder or URL"
  Open the plist in the repo.
  ```
3. Install Homebrew. (http://brew.sh)

  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```
4. Install Tmux.

  ```
  brew install tmux
  ```
5. Install reattach-to-user-namespace

  ```
  brew install reattach-to-user-namespace
  ```
6. Install Tmux Plugin Manager ((TPM)[https://github.com/tmux-plugins/tpm])

  ```
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```
7. Run the following commands to symlink the files in the repo to the apporpriate places.

  ```
  mkdir ~/.tmux
  mkdir ~/.config
  mkdir ~/.config/powerline-shell
  export repo_dir=/path/to/this/repo
  ln -s $repo_dir/bash_profile           ~/.bash_profile
  ln -s $repo_dir/bashrc                 ~/.bashrc
  ln -s $repo_dir/git_ignore             ~/.gitignore
  ln -s $repo_dir/irbrc                  ~/.irbrc
  ln -s $repo_dir/powerline_shell_config ~/.config/powerline-shell/config.json
  ln -s $repo_dir/rspecrc                ~/.rspec
  ln -s $repo_dir/aprc                   ~/.aprc
  ln -s $repo_dir/tmux_conf              ~/.tmux.conf
  ln -s $repo_dir/tmux_powerline         ~/.tmux-powerline
  ln -s $repo_dir/tmux_powerlinerc       ~/.tmux-powerlinerc
  ln -s $repo_dir/pop_tmux               ~/.tmux/poppays
  ln -s $repo_dir/vimrc                  ~/.vimrc
  ```
8. Configure git globals

  ```
  git config --global core.editor "vim"
  git config --global push.default simple
  git config --global user.name "Jack Hall"
  git config --global user.email jack@popularpays.com
  git config --global core.excludesfile '~/.gitignore'
  ```
9. Clone and install the powerline fonts.

  ```
  git clone https://github.com/powerline/fonts
  cd fonts
  ./install.sh
  ```
10. Set up powerline-shell.
  - https://github.com/milkbikis/powerline-shell#setup **#TODO:** Add a fork of the powerline-shell repo to this repo to remove the dependency.
11. Clone tmux-powerline repo.

  ```
  git clone https://github.com/HallDJack/tmux-powerline
  ```
12. Install Karabiner-Elements.

  Download:
  ```
  https://pqrs.org/osx/karabiner/index.html
  ```
  Configure:
  ```
  ln -s $repo_dir/karabiner ~/.config
  launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
  ```
13. Clone Vundle.

  ```
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/plugin/Vundle.vim
  ```
14. Install Vundle.

  ```
  #Open Vim
  #Source vimrc
  :source ~/.vimrc
  #Run
  :PluginInstall
  ```
15. Install all the Vundle plugins.

  ```vim
  # Open Vim
  #Source vimrc
  :source ~/.vimrc
  #Run
  :PluginInstall
  ```
16. Vim Powerline should be set up once a Vundle is performed.
  - Source repo: https://github.com/vim-airline/vim-airline
17. Install Ctags
  ```
  brew install ctags
  ```
18. Install Gnupg

  ```
  brew install gnupg
  ```
19. Install RVM
  - https://rvm.io/rvm/install#installing-rvm
20. Install Global Gems

  ```
  rvm @global do gem install awesome_print
  rvm @global do gem install pry
  rvm @global do gem install pry-byebug
  rvm @global do gem install httplog
  ```
21. Install NPM & NPX [link](https://medium.com/@kkostov/how-to-install-node-and-npm-on-macos-using-homebrew-708e2c3877bd)

  ```
  brew install node
  npm install -g npx
  ```
22. Install alt-ruby.vim. (From Dropbox)
23. Extra Documentation incase something has gone wrong.
  - https://github.com/altercation/solarized
  - https://powerline.readthedocs.org/en/master/#powerline
  - https://github.com/powerline/powerline (Extra Powerline stuff)
  - https://gist.github.com/MohamedAlaa/2961058 (Tmux shortcuts)
