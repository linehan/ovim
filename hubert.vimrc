


"     (\.   \      ,/)
"      \(   |\     )/
"      //\  | \   /\\
"     (/ /\_#oo#_/\ \)      Saint Hubert's holy, wholly annotated vimrc
"      \/\  ####  /\/
"           `##'



" OPTIONS & SETTINGS 
" =============================================================================
" General 
" `````````````````````````````````````````````````````````````````````````````
  let mapleader=","         " Set the <Leader> key

" Display 
" `````````````````````````````````````````````````````````````````````````````
  set showcmd               " Show (partial) command in status line.
  set number                " Show line numbers.
  set ruler                 " Show the current line and column
  set fillchars=fold:\      " Set fold fill characters (default is '-') 
  set laststatus=2          " Show statusline even with one open buffer
  set cursorcolumn          " Show a highlighted cursor column

  " Right-align and configure a useful status line display
  set statusline=%=%-14.(%m\ %{&ff}\ %y\ %v%V%)\ %<%P

" Colors 
" `````````````````````````````````````````````````````````````````````````````
  set t_Co=256              " Enable 256 color support
  colorscheme zenburn       " Set the default colorscheme
  syntax on                 " Enable syntax highlighting
  set background=dark       " Tell vim the background is dark
                            " (brightens colorscheme)

  " Define an 'over length' regexp and make it's background black
  highlight OverLength ctermbg=black
  match OverLength /\%>80v.\+/

" Saving 
" `````````````````````````````````````````````````````````````````````````````
"  set autowriteall          " Auto-write a modified file (autosave)
  set hidden                " Enable hiding existing buffers

" Tabs 
" `````````````````````````````````````````````````````````````````````````````
  set tabstop=4             " Set width of hard tab
  set softtabstop=4         " Set number of spaces in soft tab
  set shiftwidth=4          " Set number of spaces to auto-indent
  set expandtab             " Always insert soft tabs (spaces) 

" Automatic formatting 
" `````````````````````````````````````````````````````````````````````````````
  set cindent               " Indent lines with C style indentation 
  set backspace=2           " Make backspace key behave itself
  set formatoptions=c,q,r,t " c - Auto-wrap comments using textwidth
                            " q - Allow formatting of comments with 'gq'
                            " r - Automatically insert comment leader
                            " t - Auto-wrap text using textwidth
  autocmd FileType make     " When editing a Makefile...
  \setlocal noexpandtab     " always insert hard tabs

" Pattern matching 
" `````````````````````````````````````````````````````````````````````````````
  set hlsearch              " Highlight all matches
  set incsearch             " Show matches immediately.
  set ignorecase            " Ignore case in search patterns.
  set smartcase             " Override 'ignorecase' pattern is ALLCAPS 

" Bracket matching 
" `````````````````````````````````````````````````````````````````````````````
  set showmatch             " Jump to matching bracket
  set matchtime=3           " Duration of matching bracket highlight
" =============================================================================



" KEYBINDINGS 
" =============================================================================
" Cursor movement 
" `````````````````````````````````````````````````````````````````````````````
  noremap <S-j> <C-D>
  noremap <S-k> <C-U>
  noremap <S-h> 5j
  noremap <S-l> 5k

" NERDTree 
" `````````````````````````````````````````````````````````````````````````````
  noremap <Leader>n :NERDTreeToggle<CR>

" Buffers/buftabs 
" `````````````````````````````````````````````````````````````````````````````
  noremap <f1> :bprev<CR>
  noremap <f2> :bnext<CR>

" Make 
" `````````````````````````````````````````````````````````````````````````````
  noremap <f4> :cn<CR>
  noremap <f3> :cp<CR>

" Vimscripts and custom functions 
" `````````````````````````````````````````````````````````````````````````````
  noremap <Leader>8 <Esc>:call <SID>ToggleColorColumn()<CR>
  noremap <Leader>7 <Esc>:call <SID>ToggleFormatColumn()<CR>
  noremap <Leader><F1> <Esc>:call CleanClose(1)<CR>
  noremap <Leader>p <Esc>:set softtabstop=4 shiftwidth=4 expandtab<CR>
  noremap <Leader>s :Gstatus<CR>
  noremap <Leader>c :Gcommit<CR>
" =============================================================================



" PLUGINS 
" =============================================================================
" Pathogen 
" `````````````````````````````````````````````````````````````````````````````
  call pathogen#infect()        " Add ~/.vim/bundle to the 'runtimepath'

" NERDTree 
" `````````````````````````````````````````````````````````````````````````````
  let NERDTreeMinimalUI=1       " Disable the goofy '? for help' message

" buftabs 
" `````````````````````````````````````````````````````````````````````````````
  let g:buftabs_only_basename=1 " Only print the filename (no parent dirs)
  let g:buftabs_marker_start="" " Disable beginning and ending marks
  let g:buftabs_marker_end=""   " Instead, we use colors to show focus 
  let g:buftabs_in_statusline=1 " Display buftabs in statusline
  let g:buftabs_active_highlight_group="StatusLineNC" " active buffer color
  let g:buftabs_inactive_highlight_group="VisualNOS"  " inactive buffer color
" =============================================================================



" VIMSCRIPTS 
" =============================================================================
" ToggleColorColumn() 
" `````````````````````````````````````````````````````````````````````````````
"  hi ColorColumn ctermbg=108
"  set colorcolumn=81            " The column to be colored 
"  let s:color_column_old=0      " ToggleColorColumn by default
"
"  function! s:ToggleColorColumn()
"        if s:color_column_old == 0
"                let s:color_column_old = &colorcolumn
"                windo let &colorcolumn = 0
"        else
"                windo let &colorcolumn=s:color_column_old
"                let s:color_column_old = 0
"        endif
"  endfunction

" CleanClose() -- close a buffer and update buftabs without disturbing windows
" `````````````````````````````````````````````````````````````````````````````
  function! CleanClose(tosave)
"    if (a:tosave == 1)
"        w!
"    endif
    let todelbufNr = bufnr("%")
    let newbufNr = bufnr("#")
    if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
        exe "b".newbufNr
    else
        bnext
    endif

    if (bufnr("%") == todelbufNr)
        new
    endif
    exe "bd!".todelbufNr
    call Buftabs_show(todelbufNr)
  endfunction
" =============================================================================


