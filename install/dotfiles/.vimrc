call pathogen#infect()
call pathogen#helptags()

" Helps force plugins to load correctly when it is turned back on
filetype off
" Enable file-type specific indentation
filetype indent on
" Enable plugins
filetype plugin on

" Enable syntax highlighting for programming languages
syntax enable
" Use an encoding that supports unicode.
set encoding=utf-8

" Don't try to be vi compatible & set compatibility to Vim only.
" - fixes the issue where arrow keys do not function properly on some systems
set nocompatible

" Display different types of white spaces.
set list
set listchars=tab:▸\ ,trail:•,extends:#,nbsp:.,eol:¬

" Display options
set showmode
set showcmd " Show (partial) command in status line.

" show the mathing brackets
set showmatch

" Highlight the line currently under cursor.
set cursorline
" Highlight the column currently under cursor.
set cursorcolumn

"" TEXT WRAPPING
" Enable line wrapping.
set wrap
" Avoid wrapping a line in the middle of a word.
set linebreak

"" INDENTATION
" Automatically indent lines while editing.
" i.e if indented, new lines will also be indented
set autoindent
" Automatically indent lines after opening a bracket in programming languages
set smartindent


" With a map leader it's possible to do extra key combinations
let mapleader = ","



" TEXT RENDERING OPTIONS



set textwidth=79
set formatoptions=tcqrn1
set tabstop=4 " Indent using four spaces.
set shiftwidth=4
set softtabstop=4 " Number of spaces per TAB while editing.
" set expandtab " Convert tabs to spaces.
set noshiftround

" USER INTERFACE OPTIONS
set ruler " Always show cursor position.
set background=dark " Use colors that suit a dark background.
set number " Show line numbers on the sidebar.
colorscheme onedark

set laststatus=2 " Always display the status bar.

" SEARCH OPTIONS
set hlsearch " Highlight matching search patterns.
set incsearch " Dynamically search while typing characters.
set ignorecase " Ignore case while searching with lowercase characters.
set smartcase " Automatically switch search to case-sensitive when search query contains an uppercase letter.

" CODE FOLDING OPTIONS
set foldmethod=marker " Folding based on marker.
set foldmarker={{,}}
" -> Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" PANE SPLITTING OPTIONS
set splitright " Open a new vertical split on the right 
set splitbelow " Open a new vertical split below.

" SWAP FILES
" Turn off swap files and backups.
set noswapfile
set nobackup
set nowritebackup

"" PLUGINS

""" NERDTree

let NERDTreeWinSize = 30
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeWinPos = "left"
let NERDTreeHighlightCursorline = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store', '.git']

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" <C-n> => Toggle nerdtree
map <C-n> :NERDTreeToggle <CR>

" <S-n> =>  Focus on nerdtree
map <S-n> :NERDTreeFocus <CR>

""" airline

let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '' 
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'

""" git-gutter

let g:gitgutter_max_signs             = 5000
let g:gitgutter_sign_added            = '+'
let g:gitgutter_sign_modified         = '»'
let g:gitgutter_sign_removed          = '_'
let g:gitgutter_sign_modified_removed = '»╌'
let g:gitgutter_map_keys              = 0
let g:gitgutter_diff_args             = '--ignore-space-at-eol'

" -> vim-closetag

" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.vue,*.js,*.jsx,*.coffee,*.erb'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" -> SHORTCUTS

" <c-v> => Paste
imap <c-v> <esc>"+pa"

" <C-i> => Toggle indentline
map <C-i> :IndentLinesToggle <CR>

" <C-L> => clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" grep recursively for word under cursor
nmap <Leader>g :tabnew\|read !grep -Hnr '<C-R><C-W>'<CR>

" sort the buffer removing duplicates
nmap <Leader>s :%!sort -u --version-sort<CR>