syntax on
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'Townk/vim-autoclose'
Plugin 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ************ Begin Config ************ "
set number

set ts=2
set sw=2
set expandtab
set autoindent
set cindent

" Easier Split Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make Splits Open Below and to the Right
set splitbelow
set splitright

" Open Splits
nmap vv :vsplit<Enter>
nmap ss :split<Enter>

" Always show airline-powerline
set laststatus=2

" Populate powerline fonts
let g:airline_powerline_fonts = 1

" Set Up Solarized
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Trim Trailing Whitespace on Save
autocmd BufWritePre * :%s/\s\+$//e

" NERDTree
nmap ,n :NERDTreeToggle<CR>
let NERDTreeWinSize=45

" Set Up Rainbow Parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" CtrlP
" Remap to ,t
let g:ctrlp_map = ',t'
nnoremap <silent> ,t :CtrlPMixed<CR>
" Remap to ,b
nnoremap <silent> ,b :CloseSingleConque<CR>:CtrlPBuffer<cr>
" Ignore VCS files
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" Default to filename searches - so that appctrl will find application controller
let g:ctrlp_by_filename = 1