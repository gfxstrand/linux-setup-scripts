set smartcase
set nocompatible

"Load plugins from ~/.vim/bundle
call pathogen#infect() 

function SetTabWidth(width)
    if (a:width == 8)
        let &l:shiftwidth = 8
        let &l:tabstop = 8
        setlocal noexpandtab
    else
        let &l:shiftwidth = a:width
        let &l:tabstop = a:width
        let &l:softtabstop = a:width
        setlocal expandtab
    endif
endfunction

" Enable spellcheck on a variety of formats
au BufRead,BufNewFile *.txt :set spell spelllang=en_us
au BufRead,BufNewFile *.html :set spell spelllang=en_us
au BufRead,BufNewFile *.tex :set spell spelllang=en_us
au BufRead,BufNewFile *.md,*.wiki :set spell spelllang=en_us

" XML and HTML should be two-spaced
au BufRead,BufNewFile *.html,*.xml,*.rhtml :call SetTabWidth(2)
" Ruby too
au BufRead,BufNewFile *.rb :call SetTabWidth(2)

" Needed for glsl
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

" Needed for Vala
au BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setf vala

" Needed for bitbucket wiki files
au BufNewFile,BufRead *.wiki setf creole

filetype on
syntax on

set mouse=a

set wrap
set ruler
set textwidth=75

set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4

set expandtab

set incsearch

"Disable markdown folding
let g:vim_markdown_folding_disabled=1
let g:pandoc_no_folding=1
let g:pandoc_use_hard_wraps = 1

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

:inoremap jk <esc>
