" Use my vimrc so things are messed up
let g:skip_global_vimrc = 1     " Skip /etc/vimrc
let g:skip_defaults_vim = 1     " Skip defaults.vim
set all&
set nocompatible

let g:vim_ang_rev = getenv('VIM_ANG_REV')

" A collection of plugins that provide quality of life improvements
call plug#begin()
    Plug 'lervag/vimtex'
        let g:tex_flavor='pdflatex'
        let g:vimtex_view_method='skim'
        let g:vimtex_quickfix_mode=0
        set conceallevel=0
        let g:tex_conceal='abdmg'
        let g:vimtex_compiler_method = 'latexmk'
    Plug 'vim-airline/vim-airline'
    Plug 'kien/ctrlp.vim'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdcommenter'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'jiangmiao/auto-pairs'
    Plug 'luochen1990/rainbow'
    Plug 'morhetz/gruvbox'
if exists('g:vim_ang_rev') && g:vim_ang_rev
    Plug 'anufrievroman/vim-angry-reviewer'
endif
    Plug 'tibabit/vim-templates'
    Plug 'github/copilot.vim'
    Plug 'zivyangll/git-blame.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'shime/vim-livedown'
    Plug 'Yggdroot/indentLine'
call plug#end()

runtime macros/matchit.vim

filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set incsearch
set ignorecase
set smartcase
set hlsearch
set history=1000
set mouse=a
set spell spelllang=en_us
set nolist wrap
set backspace=2
set colorcolumn=80

autocmd BufRead,BufNewFile *.out set filetype=txt
autocmd FileType tex let g:indentLine_setConceal = 0

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set clipboard=unnamed
set background=dark

let mapleader = ";"

inoremap <Leader>: <Esc>

noremap <Leader>wq <C-w>

set splitbelow
set splitright

" Change panes with <leader>[h,j,k,l]
for mapcmd in ['nnoremap', 'tnoremap']
    " Switching Panes
    execute mapcmd . ' <leader>h <C-w><left>'
    execute mapcmd . ' <leader>l <C-w><up>'
    execute mapcmd . ' <leader>j <c-W><right>'
    execute mapcmd . ' <leader>k <C-w><down>'
    " Resizing Panes
    execute mapcmd . '<leader>h <c-w>5>'
    execute mapcmd . '<leader>j <c-w>5<'
    execute mapcmd . '<leader>l <c-w>5-'
    execute mapcmd . '<leader>k <c-w>5+'
    execute mapcmd . '<leader>g <c-w>='
endfor

" Splitting Planes
nnoremap <Leader>e :vsplit<cr>
nnoremap <Leader>z :split<cr>

" :q, :wq, and :x
nnoremap <Leader>q      :q<cr>
tnoremap <Leader>q <c-w>:q!<cr>
nnoremap <Leader>Q      :q!<cr>
nnoremap <Leader>w      :w<cr>
nnoremap <Leader>W      :w!<cr>
nnoremap <Leader>x      :x<cr>
nnoremap <Leader>X      :x!<cr>


" Remove trailing white space with ;fw
map <leader>fw :FixWhitespace <enter>

" Set color scheme for bottom banner
let g:airline_theme='gruvbox'

" Open ctrlp file search
let g:ctrlp_map = 'ns'

" Always colorful delimeters
let g:rainbow_active = 1

" Opn a terminal to the bottom of the screen
nnoremap <Leader>tv    :vertical  :term ++close<cr>
nnoremap <Leader>th :term ++close<cr>

" Don't enter insert mode after inserting a new empty line
nnoremap o o<Esc>
nnoremap O O<Esc>

" Apply colorscheme
colorscheme gruvbox

" Move line down
nnoremap m i<CR><ESC>

" Updating template defaults
let g:tmpl_author_email = 'bwilfong3@gatech.edu'
let g:tmpl_author_name = 'Ben Wilfong'

" Persistent folds between sessions
augroup AutoSaveGroup
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  " BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

set viewoptions=folds,cursor
set sessionoptions=folds

" Angry reviewer options
let g:AngryReviewerEnglish = 'american'
nnoremap <leader>ar :AngryReviewer<cr>

" Auto-pairs unmapping
let g:AutoPairsMapBS = 0  " Disable backspace remapping
let g:AutoPairsMapCR = 0  " Disable enter remapping

" Livedown preview toggle
nmap gm :LivedownToggle<CR>

" Python build shortcut
imap <F1> <Esc>:w<CR>:!clear;python %<CR>
nmap <F1> <Esc>:w<CR>:!clear;python %<CR>

imap <F2> <Esc>:w<CR>:!clear;pdflatex %<CR>
nmap <F2> <Esc>:w<CR>:!clear;pdflatex %<CR>

imap <F3> <Esc>:w<CR>:!clear;open %:r.pdf<CR>
nmap <F3> <Esc>:w<CR>:!clear;open %:r.pdf<CR>
