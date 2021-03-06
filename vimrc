"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          _
"      __ | \
"     /   | /
"     \__ | \
" by Amix - http://amix.dk/
"
" Maintainer:	Amir Salihefendic <amix3k at gmail.com>
" Version: 2.7
" Last Change: 12/10/06 00:09:21
"
" Sections:
" ----------------------
"   *> General
"   *> Colors and Fonts
"   *> Fileformats
"   *> VIM userinterface
"   ------ *> Statusline
"   *> Visual
"   *> Moving around and tabs
"   *> General Autocommands
"   *> Parenthesis/bracket expanding
"   *> General Abbrevs
"   *> Editing mappings etc.
"   *> Command-line config
"   *> Buffer realted
"   *> Files and backups
"   *> Folding
"   *> Text options
"   ------ *> Indent
"   *> Spell checking
"   *> Plugin configuration
"   ------ *> Yank ring
"   ------ *> File explorer
"   ------ *> Minibuffer
"   ------ *> Tag list (ctags) - not used
"   ------ *> LaTeX Suite things
"   *> Filetype generic
"   ------ *> Todo
"   ------ *> VIM
"   ------ *> HTML related
"   ------ *> Ruby & PHP section
"   ------ *> Python section
"   ------ *> Cheetah section
"   ------ *> Vim section
"   ------ *> Java section
"   ------ *> JavaScript section
"   ------ *> C mappings
"   ------ *> SML
"   ------ *> Scheme bindings
"   *> Snippets
"   ------ *> Python
"   ------ *> javaScript
"   *> Cope
"   *> MISC
"
"  Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"  Example:
"   Go into command-line mode and type helpgrep nocompatible, ie.
"   :helpgrep nocompatible
"   then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for tpl
runtime bundles/tplugin_vim/macros/tplugin.vim
" use pathogen.vim to manage plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

fun! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfun

"add file encode related
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,gbk


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add ctags list by sauturn 09-12-15
let Tlist_Ctags_cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 30
let Tlist_Auto_Open = 0

" Load a tag file
" Loads a tag file from ~/.vim.tags/, based on the argument provided. The
" command "Ltag"" is mapped to this function.
:function! LoadTags(file)
:   let tagspath = $HOME . "/.vim.tags/" . a:file
:   let tagcommand = 'set tags+=' . tagspath
:   execute tagcommand
:endfunction
:command! -nargs=1 Ltag :call LoadTags("<args>")
" added by saturn for TOhtml

" Vimwiki to use markdow syntax to replace wiki syntax
let g:vimwiki_list = [
      \{'path': '~/Documents/Wiki/Default/',
      \ 'path_html': '~/Documents/Wiki/Sites/wiki/',
      \ 'html_footer': '~/Documents/Wiki/Default/footer.tpl',
      \ 'html_header': '~/Documents/Wiki/Default/header.tpl',
      \ 'syntax': 'markdown',
      \ 'auto_export': 0}
      \]
"\ 'index' : 'main',
"\ 'ext'   : '.markdown',
" \ 'syntax': 'markdown',
" \ 'ext'   : '.markdown',

" Cscope settings
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current dir
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
endif

"Session related. Teddy Fish 20/04/12 21:39:11
"set sessionoptions-=curdir
"set sessionoptions+=sesdir

"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM har to remember
set history=400

filetype off
"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

"Fast reloading of the .vimrc
"map <leader>s :source ~/vim_local/vimrc<cr>
"Fast editing of .vimrc
"map <leader>e :e! ~/vim_local/vimrc<cr>
"When .vimrc is edited, reload it
"autocmd! bufwritepost vimrc source ~/vim_local/vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
"syntax enable
syntax on

""syntax": "markdown"


"Set font to Monaco 10pt
if MySys() == "mac"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h14
  set nomacatsui
  set termencoding=macroman
elseif MySys() == "linux"
  "set gfn=Monospace\ 11
  "set gfn=Inconsolata-g\ 12
  set gfn=Panic\ Sans\ 12
  set guifontwide=WenQuanYi\ Zen\ Hei\ 12
  "set guifontwide=WenQuanYi\ Micro\ Hei\ 11
elseif MySys() == "windows"
  "set guifont=Courier_New:h12:cANSI
  au BufRead set guifontwide=Consolas:h12
  set guifont=Consolas:h12,\ Courier_New:h12:cANSI
  "set guifont=Courier_New:h12:cANSI
  "au GUIEnter * simalt ~x "maxize
  "set gfn=Consolas\ 14
  "set gfn=Inconsolata\ 14
endif

if has("gui_running")
  set guioptions-=T
  set background=dark
  "let psc_style='cool'
  "colorscheme ps_color
  "colorscheme wombat
  "set background=light
  colorscheme solarized
  "colorscheme zenburn
  "colorscheme vilight
else
  set background=dark
  "set background=light
  "colorscheme zellner
  "colorscheme wombat
  "let g:solarized_termcolors=256
  colorscheme solarized
  "colorscheme vividchalk
  "colorscheme zenburn
  "colorscheme vilight
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set syntax=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>
map <leader>5 :set syntax=markdown<cr>

autocmd BufEnter * :syntax sync fromstart

"Highlight current
if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333 
  hi CursorColumn guibg=#333333
endif

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

  """"""""""""""""""""""""""""""
  " => Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
     "let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     let curdir = substitute(getcwd(), '/Users/teddy/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  "set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
  " 2011年10月30日 10:47:48  add the fileencoding support http://vim.wikia.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
  set statusline=\ %f%m%r%h\ %y%{\"[\".(&fenc==\"\"?&enc:&fenc).\"]\"}\ \ CWD:\ %r%{CurDir()}%h\ \ Line:\ %l/%L:%c



""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
"map <leader>bd :Bclose<cr>
"map <down> <leader>bd
"Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
imap <d-l> <esc>:exec "normal f" . leavechar<cr>a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab tdate <c-r>=strftime("=%d%m%Y")<cr>

"iab xname Amir Salihefendic
"iab xdate <c-r>=strftime("%Y年%m月%d日 %H:%M:%S")<cr>
iab xname Teddy Fish


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set completeopt=menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
map <c-q> :sb 

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Buffer - reverse everything ... :)
map <F9> ggVGg?

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=1
set fdm=indent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>
au FileType vim,javascript setl shiftwidth=2
au FileType vim,javascript setl tabstop=2
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4
" for Markdown syntax 
autocmd FileType markdown,html setl shiftwidth=4 sts=4 ts=4
" Teddy Fish added for python indent
autocmd FileType python setl ts=4 et sta sw=4 sts=4
" turn on python syntax highlight 2012年04月12日 01:04:17 
let python_highlight_all=1
"set iskeyword+=:

set smarttab
set lbr
set tw=500
"Teddy Fish 2011年05月28日 15:17:31 
set list
set listchars=tab:▸\ ,eol:¬
"set listchars=tab:>- ,eol:<


   """"""""""""""""""""""""""""""
   " => Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   set cindent

   "Wrap lines
   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """""""""""""""""""""""""""""
   " => Vim-task --map Ctrl+Command+Enter for toggling task status
   """"""""""""""""""""""""""""
   "inoremap <silent> <buffer> <C-D-CR> <ESC>:call Toggle_task_status()<CR>i
   autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks setfiletype task
   autocmd FILETYPE task,tasks inoremap <silent> <buffer> <leader>tt <ESC>:call Toggle_task_status()<CR>i
   noremap <silent> <buffer> <leader>tk :call Toggle_task_status()<CR>

   """"""""""""""""""""""""""""""
   " => Vim Grep
   """"""""""""""""""""""""""""""
   let Grep_Skip_Dirs = 'RCS CVS SCCS .svn'
   let Grep_Cygwin_Find = 1

   """"""""""""""""""""""""""""""
   " => Yank Ring
   """"""""""""""""""""""""""""""
   map <leader>y :YRShow<cr>

   """"""""""""""""""""""""""""""
   " => File explorer
   """"""""""""""""""""""""""""""
   "Split vertically
   let g:explVertical=1

   "Window size
   let g:explWinSize=35

   let g:explSplitLeft=1
   let g:explSplitBelow=1

   "Hide some files
   let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

   "Hide the help thing..
   let g:explDetailedHelp=0


   """"""""""""""""""""""""""""""
   " => Minibuffer
   """"""""""""""""""""""""""""""
   let g:miniBufExplModSelTarget = 1
   let g:miniBufExplorerMoreThanOne = 2
   let g:miniBufExplModSelTarget = 0
   let g:miniBufExplUseSingleClick = 1
   let g:miniBufExplMapWindowNavVim = 1
   let g:miniBufExplVSplit = 25
   let g:miniBufExplSplitBelow=1

   let g:bufExplorerSortBy = "name"

   autocmd BufRead,BufNew :call UMiniBufExplorer


   """"""""""""""""""""""""""""""
   " => Tag list (ctags) - not used
   """"""""""""""""""""""""""""""
   "let Tlist_Ctags_Cmd = "/sw/bin/ctags-exuberant"
   "let Tlist_Sort_Type = "name"
   "let Tlist_Show_Menu = 1
   "map <leader>t :Tlist<cr>


   """"""""""""""""""""""""""""""
   " => LaTeX Suite things
   """"""""""""""""""""""""""""""
   set grepprg=grep\ -nH\ $*
   let g:Tex_DefaultTargetFormat="pdf"
   let g:Tex_ViewRule_pdf='xpdf'

   "Bindings
   autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

   "Auto complete some things ;)
   autocmd FileType tex inoremap $i \indent 
   autocmd FileType tex inoremap $* \cdot 
   autocmd FileType tex inoremap $i \item 
   autocmd FileType tex inoremap $m \[<cr>\]<esc>O


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " => Todo
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   "au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

   """"""""""""""""""""""""""""""
   " => VIM
   """"""""""""""""""""""""""""""
   autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>
   

   """"""""""""""""""""""""""""""
   " => HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1
   "Teddy Fish 2011年08月16日 22:03:37 smarty filetype
   au BufRead,BufNewFile *.tpl set filetype=smarty.html
   au Filetype smarty exec('set dictionary=/home/teddy/.vim/syntax/smarty.vim')
   au Filetype smarty set complete+=k
" HTML tag closing macro
":let g:closetag_html_style=1
"autocmd Filetype html source "/home/teddy/.vim/closetag.vim"


   """"""""""""""""""""""""""""""
   " => Ruby & PHP section
   """"""""""""""""""""""""""""""
   autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
   autocmd FileType php compiler php
   autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>
   "add by teddy 11-01-16 for PHP function autocomplete
   autocmd FileType php set dictionary=~/.vim/ftplugin/php_funclist.txt
   autocmd FileType css set dictionary+=~/.vim/ftplugin/css.txt
   autocmd FileType javascript set dictionary+=~/.vim/ftplugin/javascript.txt
   "set dict-=/home/teddy/.vim/ftplugin/php_funclist.txt dict+=/home/teddy/.vim/ftplugin/php_funclist.txt
   "set complete-=k  complete+=k
   "Omni completion set 2011年05月31日 22:40:33 
   autocmd FileType php setlocal omnifunc=phpcomplete #Complete
   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
   autocmd FileType css set omnifunc=csscomplete#CompleteCSS
   autocmd FileType c set omnifunc=ccomplete#Complete
   autocmd FileType java set omnifunc=javacomplete#Complete
   "map somekey to reduce typing 2011年06月01日 21:01:23 
   "
   "inoremap <C-F>    <C-X><C-F>
   "inoremap <C-D>    <C-X><C-D>
   "inoremap <C-L>    <C-X><C-L>

   " For superTab
   " 0 don't record last completion.
   " 1 record last completion method until use other method.
   " 2 record last completion until the user hit 'ESC'
   let g:SuperTabRetainCompletionType = 2
   "let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 
   "let g:SuperTabDefaultCompletionType = "context" 
   "let g:superTabMappingForward = '<nul>'
   "let g:superTabMappingBackward = '<s-nul>'
   
   "Teddy Fish 2011年04月27日 22:22:11 
   inoremap <C-F>   <C-X><C-F>
   inoremap <C-N>   <C-X><C-N>

   

   """"""""""""""""""""""""""""""
   " => Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
   "au FileType python so ~/vim_local/syntax/python.vim
   autocmd FileType python map <buffer> <leader><space> :w!<cr>:!python %<cr>
   "autocmd FileType python so ~/vim_local/plugin/python_fold.vim

   "Set some bindings up for 'compile' of python
   autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
   autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

   "Python iMaps
   au FileType python set cindent
   au FileType python inoremap <buffer> $r return 
   au FileType python inoremap <buffer> $s self 
   au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
   au FileType python inoremap <buffer> $i import 
   au FileType python inoremap <buffer> $p print 
   au FileType python inoremap <buffer> $d """<cr>"""<esc>O

   "Run in the Python interpreter
   function! Python_Eval_VSplit() range
     let src = tempname()
     let dst = tempname()
     execute ": " . a:firstline . "," . a:lastline . "w " . src
     execute ":!python " . src . " > " . dst
     execute ":pedit! " . dst
   endfunction
   au FileType python vmap <F7> :call Python_Eval_VSplit()<cr> 

   """"""""""""""""""""""""""""""
   " => Cheetah section
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah set ft=xml
   autocmd FileType cheetah set syntax=cheetah

   """""""""""""""""""""""""""""""
   " => Vim section
   """""""""""""""""""""""""""""""
   autocmd FileType vim set nofen

   """""""""""""""""""""""""""""""
   " => Java section
   """""""""""""""""""""""""""""""
   au FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi

   "Java comments
   autocmd FileType java source ~/vim_local/macros/jcommenter.vim
   autocmd FileType java let b:jcommenter_class_author='Amir Salihefendic (amix@amix.dk)'
   autocmd FileType java let b:jcommenter_file_author='Amir Salihefendic (amix@amix.dk)'
   autocmd FileType java map <buffer> <F2> :call JCommentWriter()<cr>

   "Abbr'z
   autocmd FileType java inoremap <buffer> $pr private 
   autocmd FileType java inoremap <buffer> $r return 
   autocmd FileType java inoremap <buffer> $pu public 
   autocmd FileType java inoremap <buffer> $i import 
   autocmd FileType java inoremap <buffer> $b boolean 
   autocmd FileType java inoremap <buffer> $v void 
   autocmd FileType java inoremap <buffer> $s String 

   "Folding
   function! JavaFold() 
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
     syn match foldImports /\(\n\?import.\+;\n\)\+/ transparent fold

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType java call JavaFold()
   au FileType java setl fen

   au BufEnter *.sablecc,*.scc set ft=sablecc

   """"""""""""""""""""""""""""""
   " => JavaScript section
   """""""""""""""""""""""""""""""
   au FileType javascript so ~/.vim/bundle/javascript.vim/syntax/javascript.vim
   function! JavaScriptFold() 
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType javascript call JavaScriptFold()
   au FileType javascript setl fen

   au FileType javascript imap <c-t> console.log();<esc>hi
   au FileType javascript imap <c-a> alert();<esc>hi
   au FileType javascript setl nocindent
   au FileType javascript inoremap <buffer> $r return 

   au FileType javascript inoremap <buffer> $d //<cr>//<cr>//<esc>ka<space> 
   au FileType javascript inoremap <buffer> $c /**<cr><space><cr>**/<esc>ka


   """"""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   "au FileType html,cheetah set ft=xml
   "au FileType html,cheetah set syntax=html


   """"""""""""""""""""""""""""""
   " => C mappings
   """""""""""""""""""""""""""""""
   autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>


   """""""""""""""""""""""""""""""
   " => SML
   """""""""""""""""""""""""""""""
   autocmd FileType sml map <silent> <buffer> <leader><space> <leader>cd:w<cr>:!sml %<cr>


   """"""""""""""""""""""""""""""
   " => Scheme bidings
   """"""""""""""""""""""""""""""
   autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
   autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
   autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>


   """"""""""""""""""""""""""""""
   " => SVN section
   """""""""""""""""""""""""""""""
   map <F8> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg


""""""""""""""""""""""""""""""
" => Snippets
"""""""""""""""""""""""""""""""
   "You can use <c-j> to goto the next <++> - it is pretty smart ;)

   """""""""""""""""""""""""""""""
   " => Python
   """""""""""""""""""""""""""""""
   autocmd FileType python inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<cr>
   autocmd FileType python inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<cr>
  " use templates for new .py file
  autocmd BufNewFile *.py 0r ~/.vim/templates/python/tpl.py

   """""""""""""""""""""""""""""""
   " => JavaScript
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,javascript inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("function <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
   autocmd filetype cheetah,javascript inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,javascript inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,javascript inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>


   """""""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   "autocmd FileType cheetah,html inorea <buffer> cahref <c-r>=IMAP_PutTextWithMovement('<a href="<++>"><++></a>')<cr>
   "autocmd FileType cheetah,html inorea <buffer> cbold <c-r>=IMAP_PutTextWithMovement('<b><++></b>')<cr>
   "autocmd FileType cheetah,html inorea <buffer> cimg <c-r>=IMAP_PutTextWithMovement('<img src="<++>" alt="<++>" />')<cr>
   "autocmd FileType cheetah,html inorea <buffer> cpara <c-r>=IMAP_PutTextWithMovement('<p><++></p>')<cr>
   "autocmd FileType cheetah,html inorea <buffer> ctag <c-r>=IMAP_PutTextWithMovement('<<++>><++></<++>>')<cr>
   "autocmd FileType cheetah,html inorea <buffer> ctag1 <c-r>=IMAP_PutTextWithMovement("<<++>><cr><++><cr></<++>>")<cr>


   """""""""""""""""""""""""""""""
   " => Java
   """""""""""""""""""""""""""""""
   autocmd FileType java inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("public<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cfunpr <c-r>=IMAP_PutTextWithMovement("private<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++> <++> {\n<++>\n}")<cr>
   autocmd FileType java inorea <buffer> cmain <c-r>=IMAP_PutTextWithMovement("public static void main(String[] argv) {\n<++>\n}")<cr>
   

   "Presse c-q insted of space (or other key) to complete the snippet
   imap <C-q> <C-]>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Cope
map <silent> <leader><cr> :noh<cr>

"Orginal for all
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <leader>c :botright cw 10<cr>
map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
"   *> Link
"   => Anchor
function! SmartTOHtml()
   TOhtml
   try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
   catch
   endtry
   exe ":write!"
   exe ":bd"
endfunction

" Add for read PDF by Teddy 11-01-22
autocmd BufReadPre *.pdf set ro nowrap
autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -
" autocmd BufWritePost *.pdf silent !rm -rf ~/PDF/%
"autocmd BufWritePost *.pdf silent !lp -s -d pdffg "%"
"autocmd BufWritePost *.pdf silent !until [ -e ~/PDF/% ]; do sleep 1; done
"autocmd BufWritePost *.pdf silent !mv ~/PDF/% %:p:h

" Wed Feb  9 21:54:15 CST 2011
" map added to quick insert current time
map <F6> <Esc>a<c-r>=strftime("%Y-%m-%d %H:%M:%S") 

" set 256 colors 
set t_Co=256
set magic
"2011年06月01日 21:36:24 Teddy Fish -- set snipMate
"let g:snippets_dir='~/.vim/bundle/snipMate/snippets/'
"autocmd FileType html set ft=html.markdown

" add php zend snippets 2011年07月22日 21:34:51 
" ExtractSnipsFile('~/.vim/bundle/snipMate/snippets/zend', 'php') 
let g:snips_author = 'Teddy'
"indent with lispindent.lisp 2011年06月18日 11:13:02 
autocmd FileType lisp,scheme,art setlocal equalprg=lispindent.lisp
"set equalprg=lispindent.lisp

" Zen coding
let g:user_zen_settings = {
      \ 'indentation' : ' ',
      \ 'perl' : {
      \   'alias' : {
      \     'req' : 'require'
      \   },
      \   'snippets' : {
      \     'use':'use strict\n use warnings\n\n',
      \     'warn': "warn \"|\";",
      \  }
      \}
      \}
let g:user_zen_expandabbr_key='<c-y>'
let g:user_zen_complete_tag=1
" Teddy Fish 2012年03月31日 20:02:58 
" When quit and reopen the file, return to the last edit place when quit.
" au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
