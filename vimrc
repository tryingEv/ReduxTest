function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

"********************************************************
"                   一般性配置                          *
"********************************************************
"关闭vim一致性原则
set nocompatible
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"设置取消备份 禁止临时文件的生成
set nobackup
set noswapfile
"设置匹配模式
set showmatch
"设置C/C++方式自动对齐
set autoindent
set cindent
"开启语法高亮功能
syntax enable
syntax on
"指定配色方案为256色
set t_Co=256
"设置搜索时忽略大小写
set ignorecase
"配置backspace的工作方式
set backspace=indent,eol,start
"选中高亮
set hls 
"高亮光标所在行
"set cul "cursorline 
"set cuc
"set go=          " 不要图形按钮  
"color desert     " 设置背景主题  
color ron     	  " 设置背景主题  
"color torte      " 设置背景主题  
set guifont=Courier_New:h10:cANSI " 设置字体  
autocmd InsertLeave * se nocul   " 用浅色高亮当前行  
autocmd InsertEnter * se cul     " 用浅色高亮当前行  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
" 光标移动到buffer的顶部和底部时保持3行距离  
set scrolloff=3
" 总是显示状态行
set cmdheight=1
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠  
"set foldmethod=manual   " 手动折叠  
"set magic                   " 设置魔术
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
let g:indentLine_char = '┊'
"启动时不显示帮助乌干达儿童提示
set shortmess=atI 
"设置在vim中可以使用鼠标
set mouse=
set ttymouse=xterm2
"设置tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置退格键时可以删除4个空格
set smarttab
set softtabstop=4
"将tab键自动转换为空格
set expandtab
"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试以下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"检测文件类型
filetype on
"针对不同的文件采取不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"简化+寄存器操作
set clipboard=unnamedplus
"启动智能补全
filetype plugin indent on
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"达到当剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
colorscheme  molokai
"*********************************************************
"                  快捷键 配置                           *
"*********************************************************
"vmap <c-c> "+y
inoremap jk <ESC>
set pastetoggle=<F11>

"*********************************************************
"                  vundle 配置                           *
"*********************************************************
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
" My Bundles here:
Plugin 'SuperTab'
Plugin 'Vim-JavaScript'
Plugin 'a.vim'
Plugin 'c.vim'
Plugin 'Align'
Plugin 'L9'
Plugin 'vim-javacompleteex'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Yggdroot/indentLine'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ctags.vim'
Plugin 'taglist.vim'
Plugin 'The-NERD-tree'
Plugin 'Syntastic'
Plugin 'std_c.zip'
Plugin 'FuzzyFinder'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'Valloric/YouCompleteMe' 
Plugin 'Valloric/MatchTagAlways'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
call vundle#end()
filetype plugin indent on

"*****************************************************
"               MatchTagAlways配置                   *
"*****************************************************
let g:mta_use_matchparen_group = 1

"*****************************************************
"             AirLine配置                   		 *
"*****************************************************
set laststatus=2

"*****************************************************
"           FuzzyFinder配置                          *
"*****************************************************
map <leader>F :FufFile<CR>
map <leader>f :FufTaggedFile<CR>
map <leader>g :FufTag<CR>
map <leader>b :FufBuffer<CR>

"*****************************************************
"                   tagBar配置                       *
"*****************************************************
set tags=tags;  
set autochdir 
"文件侦查启动,用以检测文件的后缀
filetyp on
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/bin/ctags'
"设置tagbar的窗口宽度
let g:tagbar_width=30
"设置tagbar的窗口显示的位置,为左边
let g:tagbar_left=0
"打开文件自动 打开tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"映射tagbar的快捷键
nnoremap <silent> <F3> :TagbarToggle<CR>
"*****************************************************
"                  Ctags tagList配置                 *
"*****************************************************
function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
    endif
    execute ":cd " . curdir
endfunction

"保存文件时候自动更新ctags
autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

nmap <F10> :call UpdateCtags()<CR>

"不显示"press F1 to display help"
"let Tlist_Compact_Format=1
"默认打开
"let Tlist_Auto_Open =1
"窗口在左侧显示
"let Tlist_Use_Right_Window=1

"只显示当前文件的tags
"let Tlist_Show_One_File=1  
"高亮显示
"let Tlist_Auto_Highlight_tag=1
"随文件自动更新
"let Tlist_Auto_Update=1
"设置宽度
"let Tlist_WinWidth=30       
"taglist窗口是最后一个窗口，则退出vim
"let Tlist_Exit_OnlyWindow=1 
"单击跳转
"let Tlist_Use_SingClick=1
"打开关闭快捷键
"nnoremap <silent> <F3> :TlistToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
"autocmd vimenter * if !argc() | :TlistToggle | endif
" tag 窗口打开时，焦点转自 tag 窗口
"let Tlist_GainFocus_On_ToggleOpen=1
" 始终解析文件 tag
"let Tlist_Process_File_Always=1

"********************************************************
"                      NERD_Tree 配置                   *
"********************************************************
"显示增强
let NERDChristmasTree=1
"自动调整焦点
let NERDTreeAutoCenter=1
"鼠标模式:目录单击,文件双击
let NERDTreeMouseMode=2
"打开文件后自动关闭
let NERDTreeQuitOnOpen=0
"显示文件
let NERDTreeShowFiles=1
"显示隐藏文件
let NERDTreeShowHidden=0
"高亮显示当前文件或目录
let NERDTreeHightCursorline=1
"显示行号
let NERDTreeShowLineNumbers=1
"窗口位置
let NERDTreeWinPos='left'
"窗口宽度
let NERDTreeWinSize=31
"不显示'Bookmarks' label 'Press ? for help'
let NERDTreeMinimalUI=1
"快捷键
nnoremap <silent> <F2> :NERDTreeToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
" set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope 配置												  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("cscope")
 " set csprg=/usr/bin/cscope
 " set csto=1
 " set cst
  "set nocsverb
  " add any database in current directory
  "if filereadable("cscope.out")
    "  cs add cscope.out
  "endif
 " set csverb
"endif

map <F12> :call LoadCscope()<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call LoadCscope()
function! LoadCscope()
   let db = findfile("cscope.out", ".;")
   if (!empty(db))
	 let path = strpart(db, 0, match(db, "/cscope.out$"))
	 set nocscopeverbose " suppress 'duplicate connection' error
	 exe "cs add " . db . " " . path
	 set cscopeverbose
   endif        
endfunction

"保存文件时候自动更新cscope
autocmd BufWritePost *.c,*.h,*.cpp call LoadCscope()

":cs find s ------ 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
":cs find g ------ 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
":cs find c ------ 查找调用本函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>": 
":cs find t ------ 查找指定的字符串
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
":cs find e ------ 查找egrep模式，相当于egrep功能，但查找速度快多了
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
":cs find f ------- 查找并打开文件，类似vim的find功能
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
":cs find i ------- 查找包含本文件的文
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
":find d ------ 查找本函数调用的函数
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>cs 

":help cscope ---查看帮助
":cscope add 路径-----添加cscope数据库路径
":cs kill {num|partial_name}-----杀掉一个cscope数据库
":cs reset--------重新初始化所有的cscope数据库
":cs show--------显示cscope的链接

"*****************************************************
"           quickfix配置                             *
"*****************************************************
set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
nmap <C-n> :cnext<CR>
nmap <C-p> :cprev<CR>
nmap <C-t> :colder<CR>:cc<CR>

"让quickfix位于底部
:botright copen


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe  代码自动补全  Begin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'Valloric/YouCompleteMe'
" youcompleteme  默认tab  s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
" let g:ycm_confirm_extra_conf=0      " 关闭加载.ycm_extra_conf.py提示
let g:ycm_complete_in_comments = 1                "在注释输入中也能补全
let g:ycm_complete_in_strings = 1                "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_tags_files=1                 " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1    "注释和字符串中的文字也会被收入补全
let g:ycm_seed_identifiers_with_syntax=1            "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion=2            " 从第2个键入字符就开始罗列匹配项
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
"mapping
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>           " 跳转到申明处
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>            " 跳转到定义处
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 直接触发自动补全
let g:ycm_key_invoke_completion = '<C-Space>'
" 黑名单,不启用
let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'gitcommit' : 1,
        \}
map <F9> :call SaveInputData()<CR>
func! SaveInputData()
    exec "tabnew"
    exec 'normal "+gP'
    exec "w! /tmp/input_data"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe  代码自动补全  End

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"*****************************************************
"           Syntastic配置                            *
"*****************************************************
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1
highlight link SyntasticError Constant
highlight link SyntasticErrorSign WarningMsg

"*****************************************************
"C，C++ 按F5编译运行                                 *
"*****************************************************
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python2.7 %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

"*****************************************************
"C,C++的调试 F8                                      *
"*****************************************************
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

"*****************************************************
"新文件标题                                          *
"*****************************************************
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."),   "  > File Name   : ".expand("%")) 
        call append(line(".")+1, "  > Author      : hls") 
        call append(line(".")+2, "  > Mail        : hls@189.cn") 
        call append(line(".")+3, "  > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"*****************************************************
"代码格式优化化                                      *
"*****************************************************
map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

"********************************************************
"                   一般性配置                          *
"********************************************************
"关闭vim一致性原则
set nocompatible
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"设置取消备份 禁止临时文件的生成
set nobackup
set noswapfile
"设置匹配模式
set showmatch
"设置C/C++方式自动对齐
set autoindent
set cindent
"开启语法高亮功能
syntax enable
syntax on
"指定配色方案为256色
set t_Co=256
"设置搜索时忽略大小写
set ignorecase
"配置backspace的工作方式
set backspace=indent,eol,start
"选中高亮
set hls 
"高亮光标所在行
"set cul "cursorline 
"set cuc
"set go=          " 不要图形按钮  
"color desert     " 设置背景主题  
color ron     	  " 设置背景主题  
"color torte      " 设置背景主题  
set guifont=Courier_New:h10:cANSI " 设置字体  
autocmd InsertLeave * se nocul   " 用浅色高亮当前行  
autocmd InsertEnter * se cul     " 用浅色高亮当前行  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
" 光标移动到buffer的顶部和底部时保持3行距离  
set scrolloff=3
" 总是显示状态行
set cmdheight=1
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠  
"set foldmethod=manual   " 手动折叠  
"set magic                   " 设置魔术
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
let g:indentLine_char = '┊'
"启动时不显示帮助乌干达儿童提示
set shortmess=atI 
"设置在vim中可以使用鼠标
set mouse=
set ttymouse=xterm2
"设置tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置退格键时可以删除4个空格
set smarttab
set softtabstop=4
"将tab键自动转换为空格
set expandtab
"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试以下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"检测文件类型
filetype on
"针对不同的文件采取不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"简化+寄存器操作
set clipboard=unnamedplus
"启动智能补全
filetype plugin indent on
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"达到当剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
colorscheme  molokai
"*********************************************************
"                  快捷键 配置                           *
"*********************************************************
"vmap <c-c> "+y
inoremap jk <ESC>
set pastetoggle=<F11>

"*********************************************************
"                  vundle 配置                           *
"*********************************************************
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
" My Bundles here:
Plugin 'SuperTab'
Plugin 'Vim-JavaScript'
Plugin 'a.vim'
Plugin 'c.vim'
Plugin 'Align'
Plugin 'L9'
Plugin 'vim-javacompleteex'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Yggdroot/indentLine'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ctags.vim'
Plugin 'taglist.vim'
Plugin 'The-NERD-tree'
Plugin 'Syntastic'
Plugin 'std_c.zip'
Plugin 'FuzzyFinder'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'Valloric/YouCompleteMe' 
Plugin 'Valloric/MatchTagAlways'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
call vundle#end()
filetype plugin indent on

"*****************************************************
"               MatchTagAlways配置                   *
"*****************************************************
let g:mta_use_matchparen_group = 1

"*****************************************************
"             AirLine配置                   		 *
"*****************************************************
set laststatus=2

"*****************************************************
"           FuzzyFinder配置                          *
"*****************************************************
map <leader>F :FufFile<CR>
map <leader>f :FufTaggedFile<CR>
map <leader>g :FufTag<CR>
map <leader>b :FufBuffer<CR>

"*****************************************************
"                   tagBar配置                       *
"*****************************************************
set tags=tags;  
set autochdir 
"文件侦查启动,用以检测文件的后缀
filetyp on
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/bin/ctags'
"设置tagbar的窗口宽度
let g:tagbar_width=30
"设置tagbar的窗口显示的位置,为左边
let g:tagbar_left=0
"打开文件自动 打开tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"映射tagbar的快捷键
nnoremap <silent> <F3> :TagbarToggle<CR>
"*****************************************************
"                  Ctags tagList配置                 *
"*****************************************************
function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
    endif
    execute ":cd " . curdir
endfunction

"保存文件时候自动更新ctags
autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

nmap <F10> :call UpdateCtags()<CR>

"不显示"press F1 to display help"
"let Tlist_Compact_Format=1
"默认打开
"let Tlist_Auto_Open =1
"窗口在左侧显示
"let Tlist_Use_Right_Window=1

"只显示当前文件的tags
"let Tlist_Show_One_File=1  
"高亮显示
"let Tlist_Auto_Highlight_tag=1
"随文件自动更新
"let Tlist_Auto_Update=1
"设置宽度
"let Tlist_WinWidth=30       
"taglist窗口是最后一个窗口，则退出vim
"let Tlist_Exit_OnlyWindow=1 
"单击跳转
"let Tlist_Use_SingClick=1
"打开关闭快捷键
"nnoremap <silent> <F3> :TlistToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
"autocmd vimenter * if !argc() | :TlistToggle | endif
" tag 窗口打开时，焦点转自 tag 窗口
"let Tlist_GainFocus_On_ToggleOpen=1
" 始终解析文件 tag
"let Tlist_Process_File_Always=1

"********************************************************
"                      NERD_Tree 配置                   *
"********************************************************
"显示增强
let NERDChristmasTree=1
"自动调整焦点
let NERDTreeAutoCenter=1
"鼠标模式:目录单击,文件双击
let NERDTreeMouseMode=2
"打开文件后自动关闭
let NERDTreeQuitOnOpen=0
"显示文件
let NERDTreeShowFiles=1
"显示隐藏文件
let NERDTreeShowHidden=0
"高亮显示当前文件或目录
let NERDTreeHightCursorline=1
"显示行号
let NERDTreeShowLineNumbers=1
"窗口位置
let NERDTreeWinPos='left'
"窗口宽度
let NERDTreeWinSize=31
"不显示'Bookmarks' label 'Press ? for help'
let NERDTreeMinimalUI=1
"快捷键
nnoremap <silent> <F2> :NERDTreeToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
" set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope 配置												  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("cscope")
 " set csprg=/usr/bin/cscope
 " set csto=1
 " set cst
  "set nocsverb
  " add any database in current directory
  "if filereadable("cscope.out")
    "  cs add cscope.out
  "endif
 " set csverb
"endif

map <F12> :call LoadCscope()<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call LoadCscope()
function! LoadCscope()
   let db = findfile("cscope.out", ".;")
   if (!empty(db))
	 let path = strpart(db, 0, match(db, "/cscope.out$"))
	 set nocscopeverbose " suppress 'duplicate connection' error
	 exe "cs add " . db . " " . path
	 set cscopeverbose
   endif        
endfunction

"保存文件时候自动更新cscope
autocmd BufWritePost *.c,*.h,*.cpp call LoadCscope()

":cs find s ------ 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
":cs find g ------ 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
":cs find c ------ 查找调用本函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>": 
":cs find t ------ 查找指定的字符串
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
":cs find e ------ 查找egrep模式，相当于egrep功能，但查找速度快多了
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
":cs find f ------- 查找并打开文件，类似vim的find功能
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
":cs find i ------- 查找包含本文件的文
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
":find d ------ 查找本函数调用的函数
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>cs 

":help cscope ---查看帮助
":cscope add 路径-----添加cscope数据库路径
":cs kill {num|partial_name}-----杀掉一个cscope数据库
":cs reset--------重新初始化所有的cscope数据库
":cs show--------显示cscope的链接

"*****************************************************
"           quickfix配置                             *
"*****************************************************
set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
nmap <C-n> :cnext<CR>
nmap <C-p> :cprev<CR>
nmap <C-t> :colder<CR>:cc<CR>

"让quickfix位于底部
:botright copen


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe  代码自动补全  Begin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'Valloric/YouCompleteMe'
" youcompleteme  默认tab  s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
" let g:ycm_confirm_extra_conf=0      " 关闭加载.ycm_extra_conf.py提示
let g:ycm_complete_in_comments = 1                "在注释输入中也能补全
let g:ycm_complete_in_strings = 1                "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_tags_files=1                 " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1    "注释和字符串中的文字也会被收入补全
let g:ycm_seed_identifiers_with_syntax=1            "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion=2            " 从第2个键入字符就开始罗列匹配项
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
"mapping
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>           " 跳转到申明处
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>            " 跳转到定义处
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 直接触发自动补全
let g:ycm_key_invoke_completion = '<C-Space>'
" 黑名单,不启用
let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'gitcommit' : 1,
        \}
map <F9> :call SaveInputData()<CR>
func! SaveInputData()
    exec "tabnew"
    exec 'normal "+gP'
    exec "w! /tmp/input_data"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe  代码自动补全  End

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"*****************************************************
"           Syntastic配置                            *
"*****************************************************
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1
highlight link SyntasticError Constant
highlight link SyntasticErrorSign WarningMsg

"*****************************************************
"C，C++ 按F5编译运行                                 *
"*****************************************************
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python2.7 %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

"*****************************************************
"C,C++的调试 F8                                      *
"*****************************************************
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

"*****************************************************
"新文件标题                                          *
"*****************************************************
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."),   "  > File Name   : ".expand("%")) 
        call append(line(".")+1, "  > Author      : hls") 
        call append(line(".")+2, "  > Mail        : hls@189.cn") 
        call append(line(".")+3, "  > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"*****************************************************
"代码格式优化化                                      *
"*****************************************************
map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc
