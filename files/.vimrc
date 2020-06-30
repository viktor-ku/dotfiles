" Use Vim settings, not Vi
set nocompatible

" Enable syntax
syntax on

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Auto indent
set autoindent

" Select when using the mouse
set selectmode=mouse

" Don't need backups no more
set nobackup
set nowritebackup
set noswapfile " get rid of swapfiles everywhere"

" Keep 300 lines of command line history
set history=300

" Show the cursor position all the time
set ruler

" Show partial commands
set showcmd

" Incremental searches
set incsearch

" Show tab chars
set list
set listchars=tab:>.

" Set ignorecase on
set ignorecase

" Command height
set cmdheight=1

" Set status line
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Always display status line at the bottom
set laststatus=1

" Insert tabs when using Makefile
autocmd FileType make setlocal noexpandtab
autocmd FileType c setlocal noexpandtab

" Show match
set showmatch

" Line numbers
set number

" Line numbers gutter width
set numberwidth=5

" use the number column for the text of wrapped lines
set cpoptions+=n

" redraw only when we really need to
set lazyredraw

" Break lines at word
set linebreak

" wrap broken line prefix
set showbreak=+++

" Line wrap
set textwidth=90

" Lower updatetime from 4s to 100ms (GitGutter works way better)
set updatetime=100

" Basic work with tabs
map <C-J> :tabp<Return>
map <C-K> :tabn<Return>

set listchars=tab:│\ ,nbsp:␣,trail:·,extends:>,precedes:<
set fillchars=vert:\│
set hidden

" 2 spaces for indent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2

set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*
