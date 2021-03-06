set shell=/bin/bash
runtime macros/matchit.vim

set ttyfast
set lazyredraw

augroup myvimrc
        au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | endif
augroup END


" have jsx highlighting/indenting work in .js files as well
let g:jsx_ext_required = 0

let $PATH='/usr/local/bin:' . $PATH
set encoding=utf-8
:au FocusLost * :wa "Save on focus lost

" Sessions
let g:session_autoload = 'no'

" toggle paste
set pastetoggle=<F2>

" Leader Mappings
map <Leader>w :update<CR>
autocmd StdinReadPre * let s:std_in=1

" Quick vsplit to edit vimrc from any file
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Update with latest vimrc changes
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Start vim with NERDTree open
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>f :NERDTreeToggle<Enter>

" Current file in nerdtree
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Clear highlighting on return in normal mode
nnoremap <silent> <CR> :noh<CR><CR>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with space key
nnoremap <space> za

" system clipboard
set clipboard=unnamed

" Reduce timeout after <ESC> is recieved.
set ttimeout
set ttimeoutlen=20
set notimeout

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
" map <silent> <Leader>cc :set cursorcolumn! <CR>
set cursorline

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight matches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

syntax on
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

let g:rspec_command = 'call Send_to_Tmux("NO_RENDERER=true bundle exec rspec {spec}\n")'
let g:rspec_runner = "os_x_iterm"

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " search from current directory
  let g:ag_working_path_mode="r"

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='solarized'
set t_Co=256

:set smartcase
:set ignorecase

" Color scheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark " or light
colorscheme solarized

" Numbers
set number
set numberwidth=5

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

:nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
:nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
:xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'

" Get off my lawn - helpful when learning Vim :)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement. Seemlessly navigate between Vim/Tmux panes
let g:tmux_navigator_no_mappings = 1

" This is a hack due to a neovim bug for going Left
" Details: https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"SuperTab tab down
let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
" ale linter
let g:ale_linters = {'python3': ['pylint'], 'python': ['flake8', 'yapf']}
let g:ale_fixers = {'python3': ['yapf'], 'python': ['yapf']}
nmap <F8> <Plug>(ale_fix)
let g:ale_set_highlights = 1
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_enter = 1
let g:ale_python_flake8_use_global = 0
" let g:ale_python_pylint_use_global = 0
" let g:ale_python_yapf_use_global = 0
let g:ale_virtualenv_dir_names = ['conda', 'anaconda']
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = 'flake8 --ignore=W,D401,E402,E226'
" let g:ale_python_pylint_executable = 'python3'
" let g:ale_python_yapf_executable = 'python3'
" Navigate between Ale Erros
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" cmd n, cmd p for fwd/backward in search
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" TAGBAR 
" open and close tagbar window
nmap <F9> :TagbarToggle<CR>


function! s:Open(file)
  exec('vsplit ' . a:file)
endfunction


command! AC :call <SID>CreateRelated()
