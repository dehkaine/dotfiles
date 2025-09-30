" Author: @theniceboy
" ==================== Auto load for first time uses ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:nvim_plugins_installation_completed=1
if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
	let g:nvim_plugins_installation_completed=0
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location 
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source $HOME/.config/nvim/_machine_specific.vim

 " ==================== Editor behavior ====================
let &t_ut=''                           " 避免部分终端清除背景色导致闪烁/残影
" --显示与界面
set number                             " 显示绝对行号
set relativenumber                     " 同时显示相对行号（便于跳转）
set cursorline                         " 高亮当前行
set list                               " 可视化不可见字符
set listchars=tab:\|\ ,trail:▫        " Tab 显示为“|␠”，行尾空格显示为“▫”
set wrap                               " 软换行显示长行
set tw=0                               " 不做硬换行（textwidth 设为 0）
set colorcolumn=100                    " 在第 100 列绘制参考线
set visualbell                         " 使用视觉提示代替蜂鸣
set noshowmode                         " 隐藏 -- INSERT --（交给状态栏显示）
set scrolloff=4                        " 光标上下至少保留 4 行的滚动余量
set inccommand=split                   " :s 替换时分屏实时预览
set shortmess+=c                       " 缩短补全消息，减少噪音
set virtualedit=block                  " 允许可视块选择越过行尾
" --目录与会话
set autochdir                          " 根据当前文件自动切换工作目录
set viewoptions=cursor,folds,slash,unix " 保存/恢复视图时仅保存光标/折叠，并统一路径/换行
" --安全与本地配置
set exrc                               " 允许项目内本地配置文件（.exrc/.nvimrc）
set secure                             " 与 exrc 配合：限制本地配置的危险命令
" --缩进与制表
set noexpandtab                        " 使用实际的 <Tab> 字符，不用空格
set tabstop=2                          " 一个 <Tab> 在屏幕上等于 2 列
set shiftwidth=2                       " >> 和 << 等缩进行为使用 2 列
set softtabstop=2                      " 插入模式下退格/Tab 以 2 列为步进
set autoindent                         " 新行沿用上一行缩进
set indentexpr=                        " 关闭基于表达式的缩进（仅用 autoindent）
set formatoptions-=tc                  " 关闭自动换行/注释续行（t/c 标志）
" --折叠
set foldmethod=indent                  " 依据缩进创建折叠
set foldlevel=99                       " 启动时基本全部展开
set foldenable                         " 启用折叠功能（默认展开）
" --搜索
set ignorecase                         " 搜索默认不区分大小写
set smartcase                          " 查询中含大写时自动转为区分大小写
" --超时与性能
set ttimeoutlen=0                      " 终端键码超时为 0（更灵敏）
set notimeout                          " 关闭映射超时（配合自定义多键映射）
set lazyredraw                         " 执行宏/脚本时减少重绘提升流畅度
set updatetime=100                     " CursorHold/诊断等触发间隔（ms）
" --分屏/窗口
set splitright                         " 竖向分屏在右侧打开
set splitbelow                         " 水平分屏在下方打开
" --补全
set completeopt=longest,noinsert,menuone,noselect,preview " 补全菜单策略
" --备份/交换/撤销
silent !mkdir -p $HOME/.config/nvim/tmp/backup " 确保备份/撤销目录存在
silent !mkdir -p $HOME/.config/nvim/tmp/undo   " 同上
set backupdir=$HOME/.config/nvim/tmp/backup,.  " 备份文件写入专用目录
set directory=$HOME/.config/nvim/tmp/backup,.  " 交换文件写入专用目录
if has('persistent_undo')
  set undofile                          " 启用持久化撤销
  set undodir=$HOME/.config/nvim/tmp/undo,. " 撤销文件目录
endif
" --打开文件时恢复上次光标位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " 打开文件时恢复上次光标位置


" ==================== Terminal Behaviors ====================
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert "每次打开终端都进入插入模式
" tnoremap <C-N> <C-\><C-N>
" tnoremap <C-O> <C-\><C-N>o


" ==================== Basic Mappings ====================
let mapleader=" "
nnoremap Q :q<CR>
nnoremap <LEADER>qq :q<CR>
nnoremap <LEADER>fq :q!<CR>
nnoremap <LEADER>qw :wq<CR>
nnoremap <LEADER>w :w<CR>
" Open the vimrc file anytime
nnoremap <LEADER>rc :e $HOME/.config/nvim/init.vim<CR>
nnoremap <LEADER>rv :e .nvimrc<CR>
augroup NVIMRC
    autocmd!
    autocmd BufWritePost *.nvimrc exec ":so %"
augroup END
" Copy to system clipboard
nnoremap <LEADER>Y "+yy
vnoremap Y "+y
" Find pair
noremap ,. %
vnoremap ki $%
" clear search highlighting
noremap <LEADER><CR> :nohlsearch<CR>
" Adjacent duplicate words
noremap <LEADER>sdw /\(\<\w\+\>\)\_s*\1
" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g
" Folding
nnoremap <silent> <LEADER>z za
" Add new line keep normal mode
nnoremap <silent> <LEADER>o o<Esc>
" insert a pair of {} and go to the next line
inoremap <C-b> <ESC>A {}<ESC>i<CR><ESC>ko
" insert a new line when in isert mode
inoremap <C-Enter> <Esc>o
" Better indenting in visual mode
nnoremap <silent> <LEADER>dd "_dd
nnoremap <silent> <LEADER>cc "_cc
" Move current line to above/below
nnoremap <silent> <A-i> :m .-2<CR>==
nnoremap <silent> <A-k> :m .+1<CR>==

" ==================== Cursor Movement ====================
noremap <silent> v$ v$h
" Faster in-line navigation
noremap W 5w
noremap B 5b
" Ctrl + U or E will move up/down the view port without moving the cursor
nnoremap <C-U> 5<C-y>
nnoremap <C-E> 5<C-e>
" --f/t 重复跳转（兼容 clever-f）：- / + 绑定到插件的重复命令
nmap - <Plug>(clever-f-repeat-forward)
nmap + <Plug>(clever-f-repeat-back)
xmap - <Plug>(clever-f-repeat-forward)
xmap + <Plug>(clever-f-repeat-back)
omap - <Plug>(clever-f-repeat-forward)
omap + <Plug>(clever-f-repeat-back)
" --跳回上次编辑位置（VSCode 风格）
nnoremap <leader>ye `>zz
nnoremap <leader>yb `<lt>zz
nnoremap <leader>je g;zz
" --Smart ();
inoremap <expr> <C-9> '();' . "\<Left>\<Left>"

" ==================== Window management ====================
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER><Tab> <C-w>w
noremap <LEADER>s<Tab> <C-w>x
noremap <LEADER><LEADER>k <C-w>k
noremap <LEADER><LEADER>j <C-w>j
noremap <LEADER><LEADER>h <C-w>h
noremap <LEADER><LEADER>l <C-w>l
noremap qs <C-w>o
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <LEADER><LEADER>sj :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <LEADER>sj :set splitbelow<CR>:split<CR>
noremap <LEADER><LEADER>sl :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <LEADER>sl :set splitright<CR>:vsplit<CR>
" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>
" Rotate screens
noremap <LEADER>rwv <C-w>b<C-w>K
noremap <LEADER>rwh <C-w>b<C-w>H
" Press <SPACE> + q to close the window below the current window
noremap <LEADER><LEADER>qh <C-w>h:q<CR>
noremap <LEADER><LEADER>qj <C-w>j:q<CR>
noremap <LEADER><LEADER>qk <C-w>k:q<CR>
noremap <LEADER><LEADER>ql <C-w>l:q<CR>


" ==================== Tab management ====================
" Create a new tab with tu
noremap ta :tabe<CR>
noremap tA :tab split<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>


" ==================== Markdown Settings ====================
" Toggle markdown checkbox on current line
function! ToggleMarkdownCheckbox() abort
  let lnum = line('.')
  let l    = getline(lnum)
  let NoneCheckbox = 0
  " 如果当前行是 `- [ ]` 则改为 `- [x]`
  if l =~ '^\s*-\s\[\s\]'
    let l = substitute(l, '^\(\s*-\s\)\[\s\]', '\1[x]', '')
  " 如果当前行是 `- [x]` 或 `- [X]` 则改为 `- [ ]`
  elseif l =~ '^\s*-\s\[[xX]\]'
    let l = substitute(l, '^\(\s*-\s\)\[[xX]\]', '\1[ ]', '')
  " 否则在行首（保留缩进）插入 `- [ ] `
  else
    let l = substitute(l, '^\(\s*\)', '\1- [ ] ', '')
	let NoneCheckbox = 1
  endif
  call setline(lnum, l)
  if NoneCheckbox == 1
    call cursor(lnum, strlen(l) + 1)
    call feedkeys('A', 'n')
  endif
endfunction
nnoremap <silent> <LEADER>mc :call ToggleMarkdownCheckbox()<CR>
" Snippets
" source $HOME/.config/nvim/md-snippets.vim
" auto spell
" autocmd BufRead,BufNewFile *.md setlocal spell


" ==================== Other useful stuff ====================
" Press space twice to jump to the next '<++>' and edit it
" noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>
noremap zh zz
" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
" Call figlet
" noremap tx :r !figlet 
" find and replace
noremap \s :%s//g<left><left>
noremap <LEADER>ra :%s//g<left><left>
" Compile function
noremap <LEADER>R :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'rust'
		set splitbelow
		let l:cargo_root = findfile('Cargo.toml', expand('%:p:h') . ';')
		if !empty(l:cargo_root)
			execute 'lcd ' . fnamemodify(l:cargo_root, ':h')
			:sp
			:res -10
			:term cargo run
		else
			:sp
			:res -10
			:term rustc % -o %< && time ./%<
		endif
	elseif &filetype == 'rust'
		set splitbelow
		if filereadable("Cargo.toml")
			:sp
			:res -10
			:term cargo run
		else
			:sp
			:res -10
			:term rustc % -o %< && time ./%<
		endif
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	endif
endfunc
" Smart cargo run
function! RunCargo(cmd) abort
	let l:cargo_root = findfile('Cargo.toml', expand('%:p:h') . ';')
	if empty(l:cargo_root)
		echo "Not in a cargo project"
		return
	endif
	execute 'lcd ' . fnamemodify(l:cargo_root, ':h')
	set splitbelow
	:sp
	:res -10
	execute 'term cargo ' . a:cmd
endfunction
nnoremap <LEADER>rr :call RunCargo('run')<CR>
nnoremap <LEADER>rc :call RunCargo('check')<CR>
nnoremap <LEADER>rt :call RunCargo('test')<CR>



" ==================== Install Plugins with Vim-Plug ====================
call plug#begin('$HOME/.config/nvim/plugged')

Plug 'itchyny/vim-cursorword'

" Render-markdown
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Treesitter 语法树高亮增强
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" Themes & Dress
Plug 'theniceboy/nvim-deus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" General Highlighter
Plug 'NvChad/nvim-colorizer.lua'
Plug 'RRethy/vim-illuminate'

" File navigation
Plug 'ibhagwan/fzf-lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr'
Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'

" Snippets
Plug 'theniceboy/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'theniceboy/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'cohama/agit.vim'
Plug 'kdheepak/lazygit.nvim'

" CSharp
Plug 'OmniSharp/omnisharp-vim'
Plug 'ctrlpvim/ctrlp.vim' , { 'for': ['cs', 'vim-plug'] } " omnisharp-vim dependency

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
" Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Swift
Plug 'keith/swift.vim'
Plug 'arzg/vim-swift'

" Markdown
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }

" Editor Enhancement
Plug 'petertriho/nvim-scrollbar'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'ggandor/lightspeed.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'godlygeek/tabular' " ga, or :Tabularize <regex> to align
Plug 'svermeulen/vim-subversive'
Plug 'theniceboy/argtextobj.vim'
Plug 'rhysd/clever-f.vim'
Plug 'AndrewRadev/splitjoin.vim'

" For general writing
Plug 'junegunn/goyo.vim'

" Find & Replace
Plug 'nvim-lua/plenary.nvim' " nvim-spectre dep
Plug 'nvim-pack/nvim-spectre'

" Mini Vim-APP
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'mg979/vim-xtabline'

" Other visual enhancement
Plug 'wincent/terminus'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

set re=0


" ==================== Dress up my vim ====================
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
silent! color deus

hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70
highlight! CocUnusedHighlight guifg=#8a8f98 gui=italic

" ==================== eleline.vim ====================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'deus'
" 始终显示状态栏 / 标签栏
set laststatus=2
set showtabline=2
" 左边：vim mode + 纯文件名
let g:airline_section_a = airline#section#create_left(['mode'])
let g:airline_section_b = '%t'          " %t = 仅文件名，不带路径
let g:airline_section_c = ''          " %t = 仅文件名，不带路径

" 右边：文件大小 | 文件类型 | 行:列
let g:airline_section_x = ''          " %t = 仅文件名，不带路径
let g:airline_section_y = airline#section#create_right(['filetype'])
let g:airline_section_z = '%l:%c'       " 当前行:列
" 不要的 error / warning 段直接清空
let g:airline_section_error   = ''
let g:airline_section_warning = ''

" 彻底关掉用不到的扩展，防止它们往 statusline 打补丁
let g:airline#extensions#branch#enabled     = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled        = 0
let g:airline#extensions#wordcount#enabled  = 0

" ==================== gitsigns.nvim ====================
lua <<EOF
require('gitsigns').setup({
	signs = {
    add          = { hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '▒', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
})
EOF
nnoremap <LEADER>gH :Gitsigns preview_hunk_inline<CR>
nnoremap <LEADER>gr :Gitsigns reset_hunk<CR>
nnoremap <LEADER>gb :Gitsigns blame_line<CR>
nnoremap <LEADER>g- :Gitsigns prev_hunk<CR>
nnoremap <LEADER>g= :Gitsigns next_hunk<CR>
nnoremap <silent> <LEADER>lg :LazyGit<CR>


" ==================== coc.nvim ====================
let g:coc_global_extensions = [
	\ 'coc-rust-analyzer',
	\ 'coc-yaml',
	\ 'coc-css',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-omnisharp',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-translator',
	\ 'coc-vimlsp',
	\ 'coc-yank']
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <LEADER><LEADER>sd :call Show_documentation()<CR>

nmap <silent> <LEADER>+ <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <LEADER>e :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc


" ==================== vim-instant-markdown ====================
" let g:instant_markdown_slow = 0
" let g:instant_markdown_autostart = 0
" let g:instant_markdown_autoscroll = 1


" ==================== vim-table-mode ====================
noremap <LEADER>tm :TableModeToggle<CR>
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ==================== FZF ====================
let g:fzf_preview_window = 'right:40%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <LEADER>fB :BD<CR>
noremap <LEADER>fb :FzfLua buffers<CR>
noremap <LEADER>ff :FzfLua files<CR>
noremap <LEADER>fs :Rg<CR>
noremap <LEADER>fh :FzfLua oldfiles cwd=~<CR>
noremap <LEADER>fl :FzfLua lines<CR>

let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }


" ==================== CTRLP (Dependency for omnisharp) ====================
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'

" ==================== wildfire ====================
map <c-b> <Plug>(wildfire-quick-select)
let g:wildfire_objects = {
    \ "*" : ["i'", 'i"', "i)", "i]", "i}", "it"],
    \ "html,xml" : ["at", "it"],
\ }


" ==================== Undotree ====================
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc


" ==================== vim-visual-multi ====================
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['i']                  = 'k'
let g:VM_maps['I']                  = 'K'
let g:VM_maps['Find Under']         = '<C-k>'
let g:VM_maps['Find Subword Under'] = '<C-k>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<c-n>'
let g:VM_maps["Undo"]               = 'l'
let g:VM_maps["Redo"]               = '<C-r>'


" ==================== nvim-spectre ====================
nnoremap <LEADER>rA <cmd>lua require('spectre').open()<CR>

" ==================== fzf-gitignore ====================
noremap <LEADER>gi :FzfGitignore<CR>

" ==================== OmniSharp ====================
let g:OmniSharp_typeLookupInPreview = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_selector_ui = 'ctrlp'
autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>
sign define OmniSharpCodeActions text=💡
let g:coc_sources_disable_map = { 'cs': ['cs', 'cs-1', 'cs-2', 'cs-3'] }


" ==================== goyo ====================
map <LEADER>zen :Goyo<CR>

" ==================== tabular ====================
vmap ga :Tabularize /

" ==================== xtabline ====================
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
set showtabline=2
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>

" ==================== vim-after-object ====================
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" ==================== rnvimr ====================
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> <LEADER>R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ==================== vim-subversive ====================
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)


" ==================== vim-illuminate ====================
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl


" ==================== vim-rooter ====================
let g:rooter_patterns = ['__vim_project_root', '.git/']
let g:rooter_silent_chdir = 1


" ==================== AsyncRun ====================
noremap gp :AsyncRun git push<CR>


" ==================== AsyncTasks ====================
let g:asyncrun_open = 6


" ==================== tcomment_vim ====================
" nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
nmap co gcc
vmap co gc

" ==================== any-jump ====================
nnoremap <LEADER>aj :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9

" ==================== Agit ====================
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1


" ==================== nvim-treesitter ====================
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- one of "all", "language", or a list of languages
	ensure_installed = {"typescript", "c", "bash", "rust"},
	highlight = {
		enable = true,              -- false will disable the whole extension
		-- disable = { "rust" },  -- list of language that will be disabled
	},
}
EOF
endif


" ==================== nvim-scrollbar ====================
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require("scrollbar").setup()
require("scrollbar.handlers.search").setup()
require("scrollbar").setup({
	show = true,
	handle = {
		text = " ",
		color = "#928374",
		hide_if_all_visible = true,
	},
	marks = {
		Search = { color = "yellow" },
		Misc = { color = "purple" },
	},
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = true,
	},
})
EOF
endif


" ==================== nvim-hlslens ====================
noremap <silent> = <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
" noremap <silent> - <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
"             \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>


" ==================== fzf-lua ====================
noremap <silent> <C-p> :FzfLua files<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :FzfLua oldfiles cwd=~<CR>
noremap <silent> <C-q> :FzfLua builtin<CR>
noremap <silent> <C-t> :FzfLua lines<CR>
" noremap <silent> <C-x> :FzfLua resume<CR>
noremap <silent> z= :FzfLua spell_suggest<CR>
noremap <silent> <C-w> :FzfLua buffers<CR>
noremap <leader>; :History:<CR>
augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'fzf-lua'.setup {
	global_resume = true,
	global_resume_query = true,
	winopts = {
		height = 0.95,
		width = 0.95,
		preview = {
			scrollbar = 'float',
		},
		fullscreen = false,
		vertical       = 'down:45%',      -- up|down:size
		horizontal     = 'right:60%',     -- right|left:size
		hidden         = 'nohidden',
	},
	keymap = {
		-- These override the default tables completely
		-- no need to set to `false` to disable a bind
		-- delete or modify is sufficient
		builtin = {
			["<c-f>"]      = "toggle-fullscreen",
			["<c-r>"]      = "toggle-preview-wrap",
			["<c-p>"]      = "toggle-preview",
			["<c-y>"]      = "preview-page-down",
			["<c-l>"]      = "preview-page-up",
			["<S-left>"]   = "preview-page-reset",
		},
		fzf = {
			["esc"]        = "abort",
			["ctrl-h"]     = "unix-line-discard",
			["ctrl-k"]     = "half-page-down",
			["ctrl-b"]     = "half-page-up",
			["ctrl-n"]     = "beginning-of-line",
			["ctrl-a"]     = "end-of-line",
			["alt-a"]      = "toggle-all",
			["f3"]         = "toggle-preview-wrap",
			["f4"]         = "toggle-preview",
			["shift-down"] = "preview-page-down",
			["shift-up"]   = "preview-page-up",
			["ctrl-e"]     = "down",
			["ctrl-u"]     = "up",
		},
	},
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- pager        = "delta",      -- if you have `delta` installed
    },
    man = {
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
    },
  },
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
                                        -- (name from 'previewers' table)
                                        -- set to 'false' to disable
    prompt            = 'Files❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
    -- default options are controlled by 'fd|rg|find|_opts'
    -- NOTE: 'find -printf' requires GNU find
    -- cmd            = "find . -type f -printf '%P\n'",
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts           = "--color=never --type f --hidden --follow --exclude .git",
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
  },
}
EOF
endif


" ==================== lightspeed ====================
" autocmd BufEnter * map <buffer> <nowait> { <Plug>Lightspeed_S
map <nowait> " <Plug>Lightspeed_omni_s
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'lightspeed'.setup {
  ignore_case = true,
  -- exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
  -- --- s/x ---
  -- jump_to_unique_chars = { safety_timeout = 400 },
  -- match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = true,
  -- -- Display characters in a custom way in the highlighted matches.
  -- substitute_chars = { ['\r'] = '¬', },
  -- -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- -- and forces auto-jump to be on or off.
  safe_labels= {"a", "r", "s", "t", "n", "e", "i", "o", "w", "f", "u", "y", "x", 'c', "v", "k", "m"},
  -- labels = {},
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
}
EOF
endif

" ==================== copilot.nvim ====================
let g:copilot_enabled = 1
nnoremap <silent> <leader>go :Copilot<CR>
nnoremap <silent> <leader>ge :Copilot enable<CR>
nnoremap <silent> <leader>gd :Copilot disable<CR>
" inoremap <c-p> <Plug>(copilot-suggest)
imap <silent><script><expr> <C-C> copilot#Accept("")
let g:copilot_no_tab_map = v:true
inoremap <c-e> <Plug>(copilot-next)
inoremap <c-q> <Plug>(copilot-previous)


" ==================== nvim-colorizer.lua ====================
lua <<EOF
require("colorizer").setup {
	filetypes = { "*" },
	user_default_options = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = true, -- "Name" codes like Blue or blue
		RRGGBBAA = false, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		rgb_fn = false, -- CSS rgb() and rgba() functions
		hsl_fn = false, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "virtualtext", -- Set the display mode.
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = false, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { css }, }, -- Enable sass colors
		virtualtext = "■",
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
}
EOF


" ==================== dart-vim-plugin ====================
let g:dart_corelib_highlight = v:false
let g:dart_format_on_save = v:false


" ==================== Terminal Colors ====================
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'

" ==================== Necessary Commands to Execute ====================
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

