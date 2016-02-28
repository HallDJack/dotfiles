# dotfiles
Dotfiles for tmux, vim and bash including powerline for all.

## Setup
1. Clone the repo.
2. Load the iTerm2 settings
```
Preferences > General > "Load preferences from a customer folder or URL"
Open the plist in the repo.
```
3. Run the following commands to symlink the files in the repo to the apporpriate places.
```
export repo_dir=/path/to/this/repo
ln -s $repo_dir/bash_profile   ~/.bash_profile 
ln -s $repo_dir/bashrc         ~/.bashrc
ln -s $repo_dir/tmux_conf      ~/.tmux.conf
ln -s $repo_dir/tmux_powerline ~/.tmux-powerline
ln -s $repo_dir/vimrc          ~/.vimrc
```
4. Set the git editor to be vim.
```
git config --global core.editor "vim"
```
5. Clone and install the powerline fonts.
```
git clone https://github.com/powerline/fonts
cd fonts
./install.sh
```
6. Set up powerline-shell.
  - https://github.com/milkbikis/powerline-shell#setup **#TODO:** Add a fork of the powerline-shell repo to this repo to remove the dependency.
7. Clone tmux-powerline repo.
```
git clone https://github.com/HallDJack/tmux-powerline
```
8. Vim Powerline should be set up once a Vundle is performed.
  - Source repo: https://github.com/vim-airline/vim-airline
9. Install all the Vundle plugins.
```vim
# Open vim and run the following command.
:PluginInstall
```
10. Install alt-ruby.vim. (From Dropbox)
11. Extra Documentation incase something has gone wrong.
  - https://github.com/altercation/solarized
  - https://powerline.readthedocs.org/en/master/#powerline
  - https://github.com/powerline/powerline (Extra Powerline stuff)
  - https://gist.github.com/MohamedAlaa/2961058 (Tmux shortcuts)
