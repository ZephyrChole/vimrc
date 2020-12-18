"Vim with all enhancements
"source $VIMRUNTIME/vimrc_example.vim

"Use the internal diff if available.
"Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
    set diffexpr=MyDiff()
endif
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction

"my personal settings begin here


call plug#begin('$VIM/vim82/pack/vim-plug')
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"fuzzle finder,find files with a fuzzle name
Plug 'ycm-core/YouCompleteMe'
" Plug 'https://gitee.com/talengu/YouCompleteMe'
Plug 'airblade/vim-rooter' "change current working dictionary automatically
Plug 'Raimondi/delimitMate'
"auto pair symbols like (){}
Plug 'vim-syntastic/syntastic'
"check syntax error
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'Lokaltog/vim-powerline'
Plug 'tpope/vim-unimpaired'
Plug 'nightsense/stellarized'
Plug 'jnurmine/Zenburn'
Plug 'junegunn/seoul256.vim'
Plug 'KKPMW/sacredforest-vim'
Plug 'cocopon/iceberg.vim'
Plug 'davidklsn/vim-sialoquent'
Plug 'KabbAmine/zeavim.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'
Plug 'tpope/vim-surround'
call plug#end()


au BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"avoid chaos when displaying Chinese character
set fileencodings=utf-8
set termencoding=utf-8
set encoding=utf-8


"set lines=40 columns=155
"control display size
"set nowrap
"hi search result word by word
set incsearch
"hi search result
set hlsearch
"don't display a line in two lines
set go=
"don't display icons
set clipboard+=unnamed
"make system cilpboard in vim clipboard
set expandtab
"expand tabs to spaces "
set smarttab
set tabstop=4
set shiftround
set smartindent
set nocompatible
"don't bother with vi compatibility "
set autoread
"reload files when changed on disk, i.e. via `git checkout` "
set shortmess=atI
"don't show urganda children"
set magic
"For regular expressions turn magic on "
set title
"change the terminal's title "
set nobackup
"do not keep a backup file "
set noerrorbells
"don't beep "
set visualbell
"turn off error beep/flash "
set t_vb=
set timeoutlen=500
set shiftwidth=4
set ruler
"show the current row and column "
set number
"show line numbers "
set textwidth=1000
"don't \n automatically
set showcmd
"display incomplete commands "
set showmode
"display current modes "
set showmatch
"jump to matches when entering parentheses "
set matchtime=2
"tenths of a second to show the matching parenthesis "
"set paste                     
"paste with format
set ignorecase
set laststatus=2
"display status bar
set list
"set listchars=eol:$
",tab:>-
"(convert tab to >-,)convert end of line to $
set backup
"make filename~
set swapfile
"make filename.swp
set undofile
"make filename.un~
set backupdir=$VIM\tem_file\backup
set directory=$VIM\tem_file\swp
set undodir=$VIM\tem_file\un
"set cursorline
"set cursorcolumn
set wildmenu
"complete command when typing tab
set wildmode=longest,list,full
"as above
"set infercase
"word case doesn't matter
set noic
"word case matter
set nofoldenable
"codes are not allowed to fold automatically
set linebreak
"don't break work when making newline
set guifont=Consolas:h14
set nocompatible
set backspace=indent,eol,start


syntax enable
if has('gui_running')
   set background=dark
   colorscheme stellarized
else
   colorscheme desert256
endif


hi Comment gui=italic
"hi LineNr gui=italic guifg=lightgrey
au BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ exe "normal! g'\"" |
            \ endif




"NERDTree

au StdinReadPre * let s:std_in=1
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"close vim if it's the only window left
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"open nerdtree automatically when vim starts up opening a dir
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"open nerdtree when opening a dictionary
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinPos = 'right'
"let g:NERDTreeWinSize = 
map <C-n> :NERDTreeMirror<CR>
"open NERDTree
map <C-n> :NERDTreeToggle<CR>
"close NERDTree


"fzf

map <C-p> :call fzf#run({'right':'40%','sink':'tabedit','dir':'D:\'})


"vim-rooter

let g:rooter_change_directory_for_non_project_files = 'current'


"syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
"upgrade error msg when one is solved"
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
"open when error occurs,close when there's no error
let g:syntastic_check_on_wq = 0
"check timely
let g:syntastic_enable_signs = 1
"allow you to change signs
let g:syntastic_error_symbol="x"
let g:syntastic_warning_symbol="!"
let g:syntastic_loc_list_height = 5
"change the overview height
let g:syntastic_python_flake8_quiet_messages = {
            \ "!level":  "errors",
            \ "type":    "style",
            \ "regex":   'E501',}

"vim-commentary
"为python和shell等添加注释
au FileType python,shell,coffee set commentstring=#\ %s
"修改注释风格
au FileType java,c,cpp set commentstring=//\ %s

"tagbar
nmap <silent> <F9> :TagbarToggle<CR>
"按F9即可打开tagbar界面
let g:tagbar_left = 1
"让tagbar在页面左侧显示，默认右边
let g:tagbar_width = 30
"设置tagbar的宽度为30列，默认40
let g:tagbar_autofocus = 1
"这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
let g:tagbar_sort = 0
"设置标签不排序，默认排序
"let g:tagbar_ctags_bin = "D:\ctags"
func! CompileRun()
    if &filetype == 'python'
        exec "!start python %"
    endif
endfunc
nmap <F5> :call CompileRun()<CR>


au GUIEnter * simalt ~x
"maximise window when gVim launches
set <M-l>=^[l
nmap <F2> :echo join(split(&runtimepath,','),"\n")<CR>
nmap <F3> :tabnew $VIM\_vimrc<CR><CR>
map <F6> :'<,'>normal .<CR>
"repeat the same action
nmap <delete> "_d
"delete without throwing into registers(selected first)
nmap <C-l> :Autoformat<CR>
nmap <M-l> :!black %<CR><CR>
"nmap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
imap jk <Esc>
"to delete ^m do :%s/\r//g
