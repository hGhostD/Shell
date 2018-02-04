set t_CO=256                                "颜色数量"
colorscheme atom-dark-256                   "TUI 主题颜色"
syntax on                                   "语法高亮"


"------------------------ UI     设置 ------------------------
set guifont=Fira_Code:h24                   "设置字体大小”
set macligatures                            "使 macVim 显示生效
set linespace=16                            "设置行高"
set number                                  "设置行号"
set cursorline                              "当前行高亮"
filetype indent on                          "加载不同语言设置"
set noerrorbells                            "取消错误提示音"
set vb t_vb=                                "取消警告提示音"
set guioptions-=l                           "隐藏左侧滑动进度条"
set guioptions-=L                           "隐藏左侧滑动进度条"
set guioptions-=r                           "隐藏右侧滑动进度条"
set guioptions-=R                           "隐藏右侧滑动进度条"
set showmatch                               "显示匹配括号"
set wildmenu                                "自动补全路径"
set scrolljump=5                            "向下自动滚动"
set scrolloff=3                             "向上自动滚动"


set laststatus=2                            "显示行信息"
set ruler                                   "显示行信息和状态栏信息"

set relativenumber
set hlsearch                                "搜索结果高亮"
set incsearch                               "实时显示搜索结果"
set ic                                      "搜索忽略大小写"
set autoindent
set smartindent


"------------------------ 缩进   设置 ------------------------
set tabstop=4
set softtabstop=4
set expandtab
set autoindent              "自动保持和上一行的缩进"
set nospell                 "拼写检查"

set nrformats=              "设置十进制"


"------------------------ 映射   设置 ------------------------
:map - ddp
:map + ddkp
:map <space> viw
:inoremap jk <esc>          "在插入模式按jk退出插入模式"
let mapleader=','           "设置 Leader 为 ','"
nnoremap <Leader><Space> :noh<CR>           "取消搜索高亮"
nmap <Leader>y :!echo --==<C-R><C-w>==-- ;ici <C-R><C-W><CR>  "查单词
