let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-eunuch'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-gitgutter'
"Plug 'SirVer/ultisnips'

"Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
"Plug 'StanAngeloff/php.vim'
"Plug 'Raimondi/delimitMate'
Plug 'mhartington/oceanic-next' "https://vimawesome.com/plugin/oceanic-next
"Plug 'posva/vim-vue'
"Plug 'leafgarland/typescript-vim'
"Plug 'elzr/vim-json'
"Plug 'heavenshell/vim-jsdoc'
"
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Easy-motion? https://github.com/justinmk/vim-sneak 

" For autocompletion
"Plug 'ajh17/VimCompletesMe'
" @see https://github.com/Shougo/deoplete.nvim
" @see https://github.com/neoclide/coc.nvim
call plug#end()

" ======== Theme
set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
let g:airline_theme="oceanicnext"
set guifont=Hack:h11
hi NonText guifg=#292929

" ======== generic configs
filetype plugin indent on
set cursorline
set number relativenumber           " line numbers relative to current line
set numberwidth=4                   " line number width
set signcolumn=yes                  " Always show full width line number column
set tabstop=4                        
set shiftwidth=4
set expandtab                       " Turn tabs into spaces
set nowrap                          " No wrapping
"set mouse=a                         " Enable mouse
set clipboard=unnamedplus           " Share clipboard with OS
set history=1000
set backspace=indent,eol,start
set scrolloff=4                     " Number of lines below before scroll
set wildignore+=*/.git/*,*/tmp/*,*.swp
set iskeyword+=-                    " Add "-" to the w text object
set timeoutlen=600                  " Leader timeout
set updatetime=100                  " Update speed for git-gutter
set noswapfile
set synmaxcol=200                   " Set max highlight column. Avoid loooong lines
set undodir=~/.vim/undodir          " Set undo savefile location
set undofile                        " Enable undo savefile to undo after exit

set splitbelow                      " New h-split goes below
set splitright                      " New v-split goes to the right

set foldmethod=indent               " Fold levels based on indent level
set foldlevel=10                    " Fold level when opening files

set wildoptions=pum                 " Popup list for commands (ex: e: <tab>) 
set pumblend=20                     " Popup bg transparency

set list                            " Enable invisible character
set listchars=tab:▸\ ,eol:¬         " Specifiy characters for invisibles

set inccommand=split

set diffopt+=vertical               " Vertical split diffs

"let g:netrw_dirhistmax = 0          " disable netrwhist log file
"let g:netrw_banner = 0
"let g:netrw_browse_split = 5
"let g:netrw_liststyle = 3
"let g:netrw_winsize = 25
"let g:netrw_localrmdir="rm -r"

"au BufRead,BufNewFile *.htm set filetype=php " Force php type for htm (October templates)
"au BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css " Force multipe types for vue files

"autocmd FileType vue syntax sync fromstart " Fix broken highligh for multilang vue files
autocmd VimResized * wincmd =        " Auto ajust splits on vim resize (eg: tmux resize or zoom)

let ind = indent(prevnonblank(v:lnum - 1)) " Autoindent new lines even after empty lines

" ======== Disable arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" ======== Visual line navigation
nnoremap k gk
nnoremap j gj
"nnoremap $ g$
nnoremap gk k
nnoremap gj j
"nnoremap g$ j

" ======== Folds shorcuts
nnoremap <F1> zM
nnoremap <F2> zMzr
nnoremap <F3> zMzrzr
nnoremap <F4> zR

" ======== Save
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>

" ======== Genral vim aliases
inoremap jj <ESC>

" ======== Pane navigation
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-l> <C-\><C-N><C-w>l

" ======== Fuzzy find
nnoremap <C-p> :Files<cr>
nnoremap <C-g> :Rg<cr>
nnoremap <C-f> :BLines<cr>

" ======== Auto line number type toggle
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" ======== Hide line background for non-focused splits
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" ======= Change register
" - Ex: qa  Create macro 'a'
" - cra     Edit macro 'a'
function! ChangeReg() abort
    let r = nr2char(getchar())
    if r =~# '[a-zA-Z0-9"@\-:.%#=*"~_/]'
        call feedkeys("q:ilet @" . r . " = \<C-r>\<C-r>=string(@" . r . ")\<CR>\<ESC>", 'n')
    endif
endfunction
nnoremap <silent> <leader>cr :call ChangeReg()<CR>


" ======= Netrw
" augroup netrw_mapping
"     autocmd!
"     autocmd filetype netrw call NetrwMapping()
" augroup END

" function! NetrwMapping()
"     nmap <buffer> e <cr>
" endfunction

" ======== Javascript plugin
let g:javascript_plugin_jsdoc = 1

" ======== Rust plugin
let g:rustfmt_autosave = 1

" ======== Yank highlight plugin
let g:highlightedyank_highlight_duration = 1000

" ======== DelemitMate plugin
let g:delimitMate_matchpairs = ""
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_inside_quotes = 1

" ======== JSON
let g:vim_json_syntax_conceal = 0

" ======== Git Gutter
let g:gitgutter_map_keys = 0
hi GitGutterAdd ctermfg=255 ctermbg=22
hi GitGutterChange ctermfg=255 ctermbg=130
hi GitGutterDelete ctermfg=255 ctermbg=52
hi GitGutterChangeDelete ctermfg=255 ctermbg=130

" ======= Ultisnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

" ======== Leader commands

" Swap/move lines vertically
vnoremap <C-k> :m-2<CR>gv
vnoremap <C-j> :m '>+<CR>gv
" Select previously pasted text
nmap <leader>v `[V`]
" Open vimrc
nmap <leader>nvim :vsp $MYVIMRC<cr>
nnoremap <leader>cfg :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>
" Quit file
nnoremap <leader>q :q<cr>
" Fuzzy search word under cursor in file names
nmap <leader>p :FZF -q <C-R><C-w><cr>
" Fuzzy search word under cursor in file contents
nmap <Leader>g :Rg <C-R><C-w><cr>
" Fuzzy search word under cursor in file contents
nmap <Leader>b :Buffers<cr>
" Fuzzy search word under cursor in buffer content
nmap <Leader>f :BLines <C-R><C-w><cr>
" Prev/Next diff shortcuts
nmap <Leader>z ]c <cr>
nmap <Leader>x [c <cr>
" Add ; at the end of the line
nmap <Leader>; mcA;<esc>`c
vmap <Leader>; :'<,'>norm A;<esc>,
" Add , at the end of the line
nmap <Leader>, mcA,<esc>`c
vmap <Leader>, :'<,'>norm A,<esc>,

" Change working directory to current file
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

tnoremap <Esc> <C-\><C-n>
