syntax on
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/plugin/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Townk/vim-autoclose'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mtth/scratch.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'skwp/greplace.vim'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'luochen1990/rainbow'
Plugin 'github/copilot.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

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
" Line numbers
:set number relativenumber
nmap ,l :set nonumber norelativenumber<CR>:sleep 5000m<CR>:set number relativenumber<CR>
" Automatically toggle between absolute and hybrid numbers automatically based on mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
"Turn numbers off
nmap ,nl :set nonumber norelativenumber<CR>

" Highlight everything that matches the pattern
:set hlsearch
nmap // :noh<Enter>

" Highlight the current line
set cursorline

" No Swap Files
set noswapfile

set ts=2
set sw=2
set expandtab
set autoindent
set cindent

set autoread

" ************ Begin Split Config ************ "
" Easier Split Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make Splits Open Below and to the Right
set splitbelow
set splitright

" Set default and minimum size for splits
set winheight=30
set winminheight=5
" set winwidth=128
set winminwidth=10

" Faster resizing of splits
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> } :exe "vertical resize" . (winwidth(0) * 3/2)<CR>
nnoremap <silent> { :exe "vertical resize" . (winwidth(0) * 2/3)<CR>

" Open Splits
nmap vv :vsplit<Enter>
nmap ss :split<Enter>

" Open Split in a new Tab
nmap <c-o> :tab sp<Enter>

" Close Tab
nmap <C-c> <C-W>c

" Set line wrapping
set wrap linebreak
set showbreak=+++
" ************* End Split Config ************* "

function! Rtags()
  execute "! ctags -R"
endfunction
command! Rtags call Rtags()

" Copy what was just yanked to the system clipboard with ,cc
nnoremap <leader>cc :call system('pbcopy', @0)<CR>

" Configure airline
set laststatus=2 " Always show airline-powerline
" let g:airline_theme='powerlineish' " Set airline-powerline theme.
let g:airline_theme='solarized' " Set airline-solarized theme.
let g:airline_detect_modified = 1 " Allow airline to detect modified files.
let g:airline_powerline_fonts = 1 " Populate powerline fonts.
let g:airline_solarized_normal_green = 1
let g:airline_solarized_dark_inactive_border = 1
let g:airline_solarized_bg = 'light'
let g:solarized_termcolors = 256
let g:airline#extensions#branch#displayed_head_limit = 10 "Truncate long branch names to 10 characters.


" Set Up Solarized
set background=dark
set t_Co=256
" This setting seems to have stopped working. Here is some info.
" https://github.com/altercation/vim-colors-solarized/issues/138
let g:solarized_termcolors=256
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"
let g:solarized_termtrans = 1
colorscheme solarized

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Highlight too long lines
let w:m2=matchadd('ErrorMsg', '\%>150v.\+', -1)
au BufWinEnter *.rb let w:m2=matchadd('ErrorMsg', '\%>150v.\+', -1)
" Clear highlighting with :call clearmatches()

" Trim Trailing Whitespace on Save
autocmd BufWritePre * :%s/\s\+$//e

" File auto-complete until ambiguity
set wildmenu
set wildmode=list:longest

" Scratch Config
let g:scratch_autohide = 1
let g:scratch_top = 0
let g:scratch_horizontal = 0


" NERDTree
nmap ,n :NERDTreeToggle<CR>
nmap ,f :NERDTreeFind<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"
" let NERDTreeWinSize=45
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CtrlP
" Remap to ,t
let g:ctrlp_map = ',t'
nnoremap <silent> ,t :CtrlPMixed<CR>
" Remap to ,b
nnoremap <silent> ,b :CtrlPBuffer<cr>
" Ignore VCS files
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" Default to filename searches - so that appctrl will find application controller
let g:ctrlp_by_filename = 1

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>"

" abbreviations for commonly written code segments.
iabbrev IT it '' do<CR>end
iabbrev CONT context '' do<CR>end
iabbrev DESC describe '' do<CR>end
iabbrev pry binding.pry

" Rainbow Parens
let g:rainbow_active = 1
au VimEnter * RainbowToggleOn

" Format JSON Pretty
nmap =j :%!python -m json.tool<CR>

" Set syntax highlighting for weird extentions.
au BufRead *.hbs set syntax=javascript
au BufRead *.ejs set syntax=javascript
au BufRead *.rabl set syntax=ruby
au BufRead *.rb set syntax=ruby

" flash the line that contains the cursor
" map ; :set cursorline<CR>:set cursorcolumn<CR>:sleep 100m<CR>:set nocursorline<CR>:set nocursorcolumn<CR>

" ************ Begin CoPilot Config ************ "
autocmd BufReadPre *
      \ let f=getfsize(expand("<afile>"))
      \ | if f > 100000 || f == -2
      \ | let b:copilot_enabled = v:false
      \ | endif
" ************* End CoPilot Config ************* "
