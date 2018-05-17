"===========================================================
" Author : trey
" Version : 2.0
" Email : 164355949@qq.com
" Last_modify : 2018-04-28
"
"===========================================================

" 修改leader键
let mapleader = ','
let g:mapleader = ','

" 设置 ctags文件路径
set tags=./.tags;,.tags

" 开启语法高亮
syntax on
syntax enable

" 突出显示当前行
set cursorline
"set cursorcolumn

" 修改屏幕移动快捷键
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 显示当前行号列号
set ruler
set showmode
set scrolloff=7
set nu!

" 高亮搜索文本
set hlsearch

" 搜索时忽略大小写
set ignorecase

" 增量搜索模式，即时搜索
set incsearch

" 设置tab长度
set tabstop=4

" 设置自动对齐空格数
set shiftwidth=4

"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置按退格键时可以一次删除4个空格
set softtabstop=4

"设置按退格键时可以一次删除4个空格
set smarttab

" 关闭方向键的使用
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" 设置编码方式
set encoding=utf-8

" 自动判断编码时
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"检测文件类型
filetype on
"针对不同的文件采用不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"启动智能补全
filetype plugin indent on

"定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
nmap <Leader>qq :q!<CR>
"定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
nmap <Leader>wq :wq<CR>

"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
set t_ti= t_te=

"在状态栏显示正在输入的命令
set showcmd

"set laststatus=2

" 相对行号      行号变成相对，可以用 nj  nk   进行跳转 5j   5k 上下跳5行
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对行号 便于普通模式下进行移动
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
let colorflag=1
" F1 废弃这个键
noremap <F1> <Esc>""

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"========================== 插件列表 ====================
call plug#begin('~/.vim/plugged')

Plug 'Lokaltog/vim-powerline'
Plug 'bling/vim-airline'
Plug 'dyng/ctrlsf.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
Plug 'w0rp/ale'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" 新版替代tagbar插件.
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" 延迟加载
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

"========================== 插件配置 ====================
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" ctrlsf 文件搜索，依赖ack: brew install ack
let g:ctrlsf_default_view_mode = 'compact'
nnoremap <leader>s :CtrlSF<Space>

"vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2

" NERDTree 配置.
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let NERDTreeDirArrows=0
"let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" 状态栏增强
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" tagbar配置. 打开函数列表.
nmap <Leader>e :LeaderfFunction<CR>


" 打开新的TAB.
nnoremap <leader>tt :tabnew<CR>
" 补全设置
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{1}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

" vim 主题 solarized
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

" 快速去行尾空格 使用方法：  [, + <Space>]
map <leader><space> :FixWhitespace<cr>

" 语法检查
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"========================== 配置结束 ======================

""括号引号自动补全
"Bundle 'Raimondi/delimitMate'

"更高效的移动 [,, + w/fx]
"Bundle 'Lokaltog/vim-easymotion'
"let g:EasyMotion_smartcase = 1
"" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
"map <Leader><leader>h <Plug>(easymotion-linebackward)
"map <Leader><Leader>j <Plug>(easymotion-j)
"map <Leader><Leader>k <Plug>(easymotion-k)
"map <Leader><leader>l <Plug>(easymotion-lineforward)"
"
"" 快速注释
"Bundle 'scrooloose/nerdcommenter'
"let g:NERDSpaceDelims=1
"
"" 快速加入修改环绕字符
"Bundle 'tpope/vim-surround'
"" for repeat -> enhance surround.vim, . to repeat command
"Bundle 'tpope/vim-repeat'
"
"" 多语言语法检查
"Bundle 'scrooloose/syntastic'
"let g:syntastic_error_symbol='>>'
"let g:syntastic_warning_symbol='>'
"let g:syntastic_check_on_open=1
"let g:syntastic_enable_highlighting = 0
""let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
"let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
"let g:syntastic_javascript_checkers = ['jsl', 'jshint']
"let g:syntastic_html_checkers=['tidy', 'jshint']
"highlight SyntasticErrorSign guifg=white guibg=black
"
"" buffer 操作
"Bundle "szw/vim-ctrlspace"
"" buffer操作插件
"" 打开 , b   退出 q esc Q
"" v s 分屏打开
"" d 关闭选定buffer
"
"" git 插件.
"Bundle 'airblade/vim-gitgutter'
"
"let g:airline_exclude_preview = 1
"hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold
"hi CtrlSpaceNormal   guifg=#839496 guibg=#021B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
"hi CtrlSpaceSearch   guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
"hi CtrlSpaceStatus   guifg=#839496 guibg=#002b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8
"let g:ctrlspace_default_mapping_key="<leader>b"
""Vundle配置必须 开启插件
"filetype plugin indent on
"
"
"syntax enable
"" theme 主题 设置。 true
"set t_Co=256
"set background=dark
"let g:rehash256 = 1
"" colorscheme molokai
"" colorscheme beekai
"" let g:molokai_original=1
"
"colorscheme solarized
"" colorscheme wells-colors
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
"let g:solarized_termtrans=1
"
"" git插件
"" Bundle "tpope/vim-fugitive"
"
"
"" 自动补全配置
""让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
"set completeopt=longest,menu
"
"" 增强模式中的命令行自动完成操作
"set wildmenu
"" Ignore compiled files
"set wildignore=*.o,*~,*.pyc,*.class
"
"" tab 操作
"" TODO: ctrl + n 变成切换tab的方法
"" http://vim.wikia.com/wiki/Alternative_tab_navigation
""
"" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
""map <C-2> 2gt
"map <leader>th :tabfirst<cr>
"map <leader>tl :tablast<cr>
"
"map <leader>tj :tabnext<cr>
"map <leader>tk :tabprev<cr>
"map <leader>tn :tabnext<cr>
"map <leader>tp :tabprev<cr>
"
"map <leader>te :tabedit<cr>
"map <leader>td :tabclose<cr>
"map <leader>tm :tabm<cr>
"
"" 新建tab  Ctrl+t
"nnoremap <leader>tt :tabnew<CR>
"" inoremap <C-t>     <Esc>:tabnew<CR>
"let g:last_active_tab = 1
"
"
"set nocompatible
"set hidden
"
"" 快捷切换当前路径
"nmap <leader><leader>g :lcd %:p:h<CR>
""回车即选中当前项
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>""
""设置鼠标暂时不能用。 true
"set mouse-=a
"
""autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
"autocmd FileType js setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
"" autocmd filetype vimshell inoremap <Esc> <S>
