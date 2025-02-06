" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

set encoding=utf-8
set fileformats=unix,dos,mac
set ruler

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on
set autoindent

" syntax highlighting
syntax on

" set colorscheme
color habamax

" show linenumbers to the left
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

" Set shift width to 2 spaces.
set shiftwidth=2

" Set tab width to 2 columns.
set tabstop=2

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Highlight searchterm(s)
set hlsearch 

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" confirm exit with changes
set confirm

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
let g:indentLine_char = '⦙'

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
"let g:ale_lint_on_text_changed = 'never'

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let mapleader = ","

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" begin plugin section
call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'glench/vim-jinja2-syntax'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'preservim/nerdtree'
Plug 'pedrohdz/vim-yaml-folds'

" end plugin section
call plug#end()
map <leader>e :bufdo e!<CR>

" Vim has built-in support for folding based on the indentation level 
" but the default folding rules make it hard to tell what is folded. 
" This is because the folding starts on the line following the start of a block. 
" To change this we can install the vim-yaml-folds plugin.
set foldlevelstart=20

au FileType go nmap <leader>c <Plug>(go-test)

" show hidden files (.file) in NERDTree
let NERDTreeShowHidden = 0
let NERDTreeQuitOnOpen = 1

" map Control-n to toggle NERDTree
nmap <C-n> :NERDTreeMirror<CR>:NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif 

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Stuff for the vim-go plugin
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
" this can be used to specify which linters to call, when using autosave
"let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" to prevent :GoMetaLinter running for too long
let g:go_metalinter_deadline = "5s"
let g:go_fmt_command = "goimports"

" ,t runs go test in current folder
autocmd FileType go nmap <leader>t <Plug>(go-test)

" ,b builds current context
autocmd FileType go nmap <leader>b <Plug>(go-build)

" ,c runs coverage
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

