" MADE FOR PYTHON PROGRAMMING
" Vimrc configurations made by TJ Louw
" Created on 17 November 2021


" == == == == == == == == == == == == == == == == == == == == == == == == == =
"               THIS FILE CONSISTS OF THE FOLLOWONG CONTENT:

" <BASIC >
"" Line numbers
"" Tabs / Spaces
"" Document width
"" SyntaxHighlighting


" <ADVANCED >
"" Vundle {plugin installation}
"" File Dir / NERDTree
"" Document width set to standard pep8
"" Autocompletion / jedi-vim
"" Autopep8
"" Taglist
"" Async (execute python files in vim)
"" Python-mode (syntax highlighting)
"" Speedup vim
"" Theme

" == == == == == == == == == == == == == == == == == == == == == == == == == =
"               {ADD ALL CONFIGURATIONS BELOW THIS LINE}


" <BASIC >
"" Line numbers
:set number

"" Tabs / Spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"" Document
:set colorcolumn=79
function! GetPythonTextWidth()
    if !exists('g:python_normal_text_width')
        let normal_text_width = 79
    else
        let normal_text_width = g:python_normal_text_width
    endif

    if !exists('g:python_comment_text_width')
        let comment_text_width = 72
    else
        let comment_text_width = g:python_comment_text_width
    endif

    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    if cur_syntax == "Comment"
        return comment_text_width
    elseif cur_syntax == "String"
        " Check to see if we're in a docstring
        let lnum = line(".")
        while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
            if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                " Assume that any longstring is a docstring
                return comment_text_width
            endif
            let lnum -= 1
        endwhile
    endif

    return normal_text_width
endfunction

augroup pep8
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END

"" SyntaxHighlighting
let g:python_highlight_all = 1

" == == == == == == == == == == == == == == == == == == == == == == == == == =

" <ADVANCED >
set nocompatible
filetype off
set modifiable

"" Vundle
filetype off " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'baskerville/bubblegum'
Plugin 'preservim/nerdtree'
Plugin 'davidhalter/jedi-vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'preservim/tagbar'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'python-mode/python-mode'
Plugin 'tribela/vim-transparent'
Plugin 'bling/vim-airline'
Plugin 'sickill/vim-monokai'
Plugin 'sickill/coloration'
call vundle#end() " required
filetype plugin indent on
colorscheme bubblegum-256-dark

"" File Dir / NERDTree
" Shortcuts with Ctrl
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"" AutoCompletion / jedi-vim/ YouCompleteMe
" jedi-vim
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" youcompleteme
autocmd FileType c let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_files/c/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
set encoding=utf-8

"" Autopep8
let g:autopep8_max_line_length=79
let g:autopep8_indent_size=4

"" Taglbar
" Shortcut with F8
nmap <F8> :TagbarToggle<CR>

"" Async
" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

" Deprecated:
" augroup SPACEVIM_ASYNCRUN
"     autocmd!
"    " Automatically open the quickfix window
"     autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
" augroup END
"
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 12

"" Python-mode
let g:pymode_python = 'python3'

"" Speedup vim
:set noswapfile
:set lazyredraw

"" Theme
syntax enable
colorscheme monokai " selected theme ovewrites bubblegum theme
:highlight Comment ctermfg=green cterm=bold " change comment color and set it to be bold
:hi Normal guibg=NONE ctermbg=NONE " create transparency effect to theme
set cursorcolumn " highlights current column cursor is on
set cursorline " highlights current row cursor is on


"                   {ADD ALL CONFIGARATIONS ABOVE THIS LINE}
" == == == == == == == == == == == == == == == == == == == == == == == == == =
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

"                       THIS IS THE END OF THIS FILE
" == == == == == == == == == == == == == == == == == == == == == == == == == =
