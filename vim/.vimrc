" Basic settings
syntax on
set showcmd
set foldenable
set foldmethod=manual
set nocompatible
set number
set helplang=cn
set encoding=utf-8
set fileformat=unix
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch
set cursorline
set colorcolumn=80
set textwidth=80
set foldmethod=marker
set hlsearch
set wildmenu
set list
set listchars=eol:¬,nbsp:·,tab:>-,trail:·,extends:>,precedes:<
let mapleader=";"

" Auto add head info
" Python's header
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" Shell's header
function HeaderBash()
    call setline(1, "#!/usr/bin/env bash")
    normal G
    normal o
endf
autocmd bufnewfile *.sh call HeaderBash()

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()
filetype plugin indent on

" Plugin vim-airline
set laststatus=2
nnoremap <C-N> :bn<CR>
nnoremap <C-M> :bp<CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'luna'

" Plugin vim-colors-solarized
set background=dark
colorscheme solarized

" Plugin indentLine
map <C-i> :IndentLinesToggle<CR>
let g:indentLine_char = "¦"
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:autopep8_disable_show_diff = 1

" Plugin minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne = 0

" Plugin nerdtree
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree()) | q | endif
map <C-e> :NERDTreeToggle<CR>
let NERDTreeChDirMode = 1
let NERDTreeShowBookmarks = 1
let NERDTreeWinSize = 25
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\~$', '\.pyc$', '\.swp$', '\.git$']
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

" Plugin ctrlp
map <C-p> :CtrlP<CR>

" Plugin vim-better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" Plugin tagbar
nmap <C-t> :TagbarToggle<CR>
let g:tagbar_width = 25
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

" Plugin YouCompleteMe
" set completeopt=longest,menu
" let g:ycm_min_num_of_chars_for_completion = 2
" let g:ycm_cache_omnifunc = 0
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_error_symbol = '>>'
" let g:ycm_warning_symbol = '>*'
" let g:ycm_always_populate_location_list = 1
" let g:ycm_show_diagnostics_ui = 1
" nmap <C-Y> :YcmDiags<CR>
" nnoremap <Leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <Leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <Leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Plugin ultisnips
let g:UltiSnipsExpandTrigger = "<Leader><Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Leader><Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<Leader><S-Tab>"

" Plugin nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Plugin syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>*'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1

" Plugin nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
