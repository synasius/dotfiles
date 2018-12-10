" vim:foldmethod=marker:foldlevel=0

" vim-plug {{{
call plug#begin()

" color scheme
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" syntax highlighting
Plug 'peterhoeg/vim-qml'
Plug 'artoj/qmake-syntax-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'stephpy/vim-yaml'
Plug 'rhysd/vim-clang-format'
Plug 'vim-syntastic/syntastic'

" python
Plug 'nvie/vim-flake8'
Plug 'ambv/black'

" css and sass
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" javascript world highlighting
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'mxw/vim-jsx'

" auto complete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'

" navigation/search file
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'

" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" icons
Plug 'ryanoasis/vim-devicons'

call plug#end()
" }}} vim-plug

" LanguageClient-neovim and ncm2 autocompletion {{{

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }

function SetLSPShortcuts()
    nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<CR>
    nnoremap <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent> <leader>lx :call LanguageClient#textDocument_references()<CR>
    nnoremap <silent> <leader>la :call LanguageClient_workspace_applyEdit()<CR>
    nnoremap <silent> <leader>lc :call LanguageClient#textDocument_completion()<CR>
    nnoremap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <silent> <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
    autocmd!
    autocmd FileType rust call SetLSPShortcuts()
augroup END

" NCM2

" supress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

let g:ncm2#matcher="substrfuzzy"

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect,preview

" Close the preview window once complete is done
autocmd CompleteDone * silent! pclose!

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" }}}

" Neovim {{{
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
" }}}

" Colors {{{
set termguicolors
"colorscheme gruvbox
"set background=dark
syntax enable
colorscheme OceanicNext
" }}} Colors

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" Clipboard {{{
set clipboard+=unnamedplus
" }}} Clipboard

" UI Config {{{
set hidden
set lcs=trail:·,tab:»·
set list
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set nobackup
set noswapfile
set mouse=a
let &colorcolumn="".join(range(90,999),",")

set guifont=SauceCodePro\ Nerd\ Font\ 13
" }}} UI Config

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise

" set ripgrep as the grep command
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" }}} Search

" Folding {{{
set foldenable
set foldlevelstart=10  " default folding level when buffer is opened
set foldnestmax=10     " maximum nested fold
set foldmethod=syntax  " fold based on indentation
" }}} Folding

" Leader & Mappings {{{
let mapleader=","   " leader is comma

" edit/reload vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" better ESC
inoremap jj <esc>

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" move through grep results
nmap <silent> <right> :cnext<CR>
nmap <silent> <left> :cprev<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" fast header source switch
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" fzf
nnoremap <c-p> :FZF<CR>

" NERDTree mappings
map <C-n> :NERDTreeToggle<CR>

" }}}

" FZF {{{
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" JSX {{{
let g:jsx_ext_required = 0  " enable JSX in .js files
" }}}

" NERDTree {{{
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" }}}

" Cpp Enhanced Highlighting {{{
let g:cpp_class_scope_highlight = 1
" }}}

" Airline {{{
let g:airline_theme = 'oceanicnext'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" Syntastic {{{
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" Prettier {{{
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
" }}}

" UltiSnips {{{

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"let g:UltiSnipsUsePythonVersion = 2
" }}}

" Flake8 {{{
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
" }}}

" Functions and autos {{{
" trailing whitespace
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

augroup stuff
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
    autocmd BufWritePre *.py execute ':Black'
    autocmd BufRead,BufNewFile *.scss set filetype=scss.css
augroup END


" }}}
