set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leshill/vim-json'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'claco/jasmine.vim'
Plugin 'burnettk/vim-angular'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'wesQ3/vim-windowswap'
Plugin 'Raimondi/delimitMate'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'goldfeld/vim-seek'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mileszs/ack.vim'
Plugin 'yuttie/comfortable-motion.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'szw/vim-maximizer'
Plugin 'benmills/vimux'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <C-Z> za

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=140 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set encoding=utf-8

au BufNewFile,BufRead *.js,*.html,*.css,*.jade
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

set hlsearch
let python_highlight_all=1
syntax on

set backspace=2

if has('gui_running')
  syntax enabled
  set background=light
  colorscheme solarized
else
  colorscheme zenburn
endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap ne :NERDTree<cr>

set nu

"" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

let g:jsx_ext_required = 0

filetype plugin on
set omnifunc=syntaxcomplete#Complete

"make jj do esc"
inoremap jj <Esc>

" tabs auto use spaces
set expandtab

" show diff with :DiffSaved
" turn off diff view :diffoff
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" show diff :diff
nnoremap :diff :w !diff % -

" YCM commands js
autocmd FileType javascript nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
autocmd FileType javascript nnoremap <leader>n :YcmCompleter GoToReferences<CR>
autocmd FileType javascript nnoremap <leader>t :YcmCompleter GetType<CR>

" Highlight current line
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END

" Change current line/column to block
highlight CursorLine ctermbg=Black

" Unset cap of 10k files so we find everything
let g:ctrlp_max_files = 0

" Insert single char with space + char
:nnoremap <Space> i_<Esc>r


" Insert newline before and after cursor witout entering insert mode
nnoremap OO O<Esc>j
nnoremap oo o<Esc>k

" Toggle Tagbar
nmap <F8> :TagbarToggle<CR>
command! -nargs=0 TagbarToggleStatusline call TagbarToggleStatusline()
nnoremap <silent> <c-F12> :TagbarToggleStatusline<CR>
function! TagbarToggleStatusline()
   let tStatusline = '%{exists(''*tagbar#currenttag'')?
            \tagbar#currenttag(''     [%s] '',''''):''''}'
   if stridx(&statusline, tStatusline) != -1
      let &statusline = substitute(&statusline, '\V'.tStatusline, '', '')
   else
      let &statusline = substitute(&statusline, '\ze%=%-', tStatusline, '')
   endif
endfunction

" Turn airline into tagbar
let g:airline#extensions#tagbar#flags = 'f'

" Airline Theme
let g:airline_theme='bubblegum'

" Airline statusline width
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 120,
      \ 'x': 60,
      \ 'y': 150,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

" Reduce udpate time for gitgutter
set updatetime=250

" Relative Number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" set _ as word (not WORD) boundary
set iskeyword-=_

" copy to clipboard
set clipboard=unnamed

" ack.vim 
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

cnoreabbrev ag Ack!

 " Add spaces after comment delimiters by default
 let g:NERDSpaceDelims = 1

 " Use compact syntax for prettified multi-line comments
 let g:NERDCompactSexyComs = 1

 " Align line-wise comment delimiters flush left instead of following code  indentation
 let g:NERDDefaultAlign = 'left'

 " Set a language to use its alternate delimiters by default
 let g:NERDAltDelims_java = 1

let g:ack_mappings = {
      \  'v': '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
      \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J'}


" Prompt for a command to run in tmux
map <Leader>vp :VimuxPromptCommand<CR>

" Run mas command
map <Leader>vl :VimuxRunLastCommand<CR>

" Maximizer on F3
nnoremap <leader>mt :MaximizerToggle<CR>
vnoremap <leader>mt :MaximizerToggle<CR>gv
inoremap <leader>mt <C-o>:MaximizerToggle<CR>

" Gif config
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
