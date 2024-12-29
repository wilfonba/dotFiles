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
    " Moving Panes
    execute mapcmd . ' <leader>H <C-w>J'
    execute mapcmd . ' <leader>L <C-w>K'
    execute mapcmd . ' <leader>J <c-w>L'
    execute mapcmd . ' <leader>K <C-w>J'
    " Resizing Panes
    execute mapcmd . '<leader>h <c-w>>'
    execute mapcmd . '<leader>j <c-w><'
    execute mapcmd . '<leader>l <c-w>-'
    execute mapcmd . '<leader>k <c-w>+'
    execute mapcmd . '<leader>= <c-w>='
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

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <C-n> :call NumberToggle()<CR>

" A collection of plugins that provide quality of life improvements
call plug#begin()

" Enable writing LaTeX in vim
Plug 'lervag/vimtex'
let g:tex_flavor='pdflatex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'

" Add fancy bottom banner showing mode
Plug 'vim-airline/vim-airline'

" Search for files
Plug 'kien/ctrlp.vim'

" Themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Keybindings for toggling comments on lines or groups of lines
Plug 'scrooloose/nerdcommenter'

" Highlight trailing white space in red
Plug 'bronson/vim-trailing-whitespace'

" Automatically place second delimiter
Plug 'jiangmiao/auto-pairs'

" Colorful delimeters
Plug 'luochen1990/rainbow'

" gruvbox theme
Plug 'morhetz/gruvbox'

" Style suggests for academic and scientific texts
Plug 'anufrievroman/vim-angry-reviewer'

" Templates
Plug 'tibabit/vim-templates'

" Copilot
Plug 'github/copilot.vim'

" Git blame
Plug 'zivyangll/git-blame.vim'

call plug#end()

" Remove trailing white space with ;fw
map <leader>fw :FixWhitespace <enter>

" Set color scheme for bottom banner
let g:airline_theme='distinguished'

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
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END
