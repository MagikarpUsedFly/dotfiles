" Always display the status line, even if only one window is displayed
set laststatus=2

filetype plugin indent on

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

if has('mouse')
  set mouse=a
endif

" mouse_sgr support
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

set t_Co=16

" Enable Solarized
set background=dark
colorscheme solarized

" Better command-line completion
set wildmenu
set showcmd

" highlight matching braces
set showmatch

" Use case insensitive search, except when using capital letters
" set ignorecase
set smartcase

"show search results while typing, reset when in insert mode
set incsearch
nnoremap i :noh<cr>i

"Improved vim splits
set splitbelow
set splitright

" Show column at line 81
set colorcolumn=81
set cursorline

"Hightlight BadWhitespace
highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

"aspell shortcut
map  :w!<CR>:!aspell check %<CR>:e! %<CR>

"Move by display lines when word wrap works
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

set statusline=
set statusline+=%#WildMenu#
set statusline+=\ " "
set statusline+=%{gitbranch#name()}
set statusline+=\ "    "
set statusline+=%#Pmenu#
set statusline+=\ "    "
set statusline+=%m
set statusline+=\ %F
set statusline+=\ "    "
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=%#Pmenu#
set statusline+=\ "    "
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ " "
set guitablabel=\[%N\]\ %t\ %M

"Vundle
so ~/.vim/plugins.vim
"set colorcolumn=81
