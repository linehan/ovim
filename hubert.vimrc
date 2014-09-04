


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
  set encoding=utf-8
  set showcmd               " Show (partial) command in status line.
  set number                " Show line numbers.
  set ruler                 " Show the current line and column
  set fillchars=fold:\      " Set fold fill characters (default is '-') 
  set laststatus=2          " Show statusline even with one open buffer


  set foldmethod=marker
" Colors 
" `````````````````````````````````````````````````````````````````````````````
  set t_Co=256              " Enable 256 color support
  syntax enable
  set background=dark
  colorscheme zenburn       " Set the default colorscheme
  syntax on                 " Enable syntax highlighting

" Saving 
" `````````````````````````````````````````````````````````````````````````````
  set autowriteall          " Auto-write a modified file (autosave)
  set hidden                " Enable hiding existing buffers

" Tabs 
" `````````````````````````````````````````````````````````````````````````````
  set tabstop=4             " Set width of hard tab
  set softtabstop=4         " Set number of spaces in soft tab
  set shiftwidth=4          " Set number of spaces to auto-indent
  set expandtab             " Always insert soft tabs (spaces) 

" Automatic formatting 
" `````````````````````````````````````````````````````````````````````````````
  set cindent                " Indent lines with C style indentation 
  set backspace=2            " Make backspace key behave itself
  set formatoptions=c,q,r,t  " c - Auto-wrap comments using textwidth
                             " q - Allow formatting of comments with 'gq'
                             " r - Automatically insert comment leader
                             " t - Auto-wrap text using textwidth
  autocmd FileType make      " When editing a Makefile...
      \ setlocal noexpandtab " always insert hard tabs

  autocmd BufRead,BufNewFile *.py
      \ setfiletype python

  autocmd BufRead,BufNewFile *.html
      \ setfiletype html 

  autocmd BufRead,BufNewFile *.js
      \ setfiletype javascript

  autocmd BufRead,BufNewFile *.json
      \ setfiletype javascript

  autocmd BufRead,BufNewFile *.topojson
      \ setfiletype javascript
  
  autocmd BufRead,BufNewFile *.geojson
      \ setfiletype javascript

  autocmd BufRead,BufNewFile *.coffee
      \ setfiletype coffeescript

  filetype plugin indent on

  autocmd FileType html :setlocal sw=2 ts=2 sts=2
  autocmd FileType javascript :setlocal sw=4 ts=4 sts=4
  autocmd FileType coffeescript :setlocal sw=2 ts=2 sts=2

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
" Keep pasted buffer from being auto-indented and print mode value.
  noremap <F6> :set invpaste paste?<CR>
  set pastetoggle=<F6>
  set showmode
" Execute python file being edited
  noremap <buffer> <S-e> :w<CR>:!/usr/bin/env python2 % <CR>

" Colorcolumn stuff 
  noremap <Leader>8 <Esc>:call <SID>ToggleColorColumn()<CR>
  noremap <Leader>7 <Esc>:call <SID>ToggleFormatColumn()<CR>

" Close a buffer
  noremap <Leader><F1> <Esc>:call CleanClose(1)<CR>
" Set 4-space tabs
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
  let NERDChristmasTree=1       " Tells the NERD tree to make itself colourful
  let NERDTreeWinSize=31        " Default is 31

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
  hi ColorColumn ctermbg=108
  if exists('+colorcolumn')
          set colorcolumn=81            " The column to be colored 
  endif
  let s:color_column_old=0      " ToggleColorColumn by default

  function! s:ToggleColorColumn()
        if s:color_column_old == 0
                let s:color_column_old = &colorcolumn
                windo let &colorcolumn = 0
        else
                windo let &colorcolumn=s:color_column_old
                let s:color_column_old = 0
        endif
  endfunction

" CleanClose() -- close a buffer and update buftabs without disturbing windows
" `````````````````````````````````````````````````````````````````````````````
  function! CleanClose(tosave)
    if (a:tosave == 1)
        w!
    endif
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
    exe "bd".todelbufNr
    call Buftabs_show(todelbufNr)
  endfunction

" QFDo() -- Run a command on each item in the quickfix buffer.
" ````````````````````````````````````````````````````````````
function! QFDo(command)
    " Create a dictionary so that we can get the list of 
    " buffers rather than the list of lines in buffers
    " (easy way to get unique entries).
    let buffer_numbers = {}
    " For each entry, use the buffer number as a dictionary 
    " key (won't get repeats).
    for fixlist_entry in getqflist()
        let buffer_numbers[fixlist_entry['bufnr']] = 1
    endfor
    " Make it into a list as it seems cleaner
    let buffer_number_list = keys(buffer_numbers)

    " For each buffer
    for num in buffer_number_list
        " Select the buffer
        exe 'buffer' num
        " Run the command that's passed as an argument
        exe a:command
        " Save if necessary
        update
    endfor
endfunction

" =============================================================================
let NERDTreeIgnore = ['\.pyc$']
"
