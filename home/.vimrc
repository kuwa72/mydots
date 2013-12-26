if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neobundle-vim-recipes'

" Recommended to install
NeoBundle 'Shougo/vimproc', {
 \ 'build' : {
 \     'windows' : 'make -f make_mingw32.mak',
 \     'cygwin' : 'make -f make_cygwin.mak',
 \     'mac' : 'make -f make_mac.mak',
 \     'unix' : 'make -f make_unix.mak',
 \    },
 \ }

" My Bundles here:
" Refer to |:NeoBundle-examples|.
"
" Note: You don't set neobundle setting in .gvimrc!

" ...
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'honza/vim-snippets'
" HTML input support. like CSS Selector.
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'Shougo/vimfiler'
NeoBundle '907th/vim-auto-save'
NeoBundle "pangloss/vim-javascript"
if has('gui_running')
  NeoBundle 'fuenor/im_control.vim'
endif
" <Leader>[move] fast move method.
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'L9'
" File open support
NeoBundle 'FuzzyFinder'
" Read/Write remote file
NeoBundle 'netrw.vim'
" reStructuredText plugin
NeoBundle 'Rykka/riv.vim'

NeoBundle 'fuenor/JpFormat.vim'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

"------------------------------------
" Encode
"------------------------------------
set fileformats=unix,dos,mac " 改行コード
set encoding=utf-8 " デフォルトエンコーディング
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc " ワイルドカードで表示するときに優先度を低くする拡張子

"------------------------------------
" Basic
"------------------------------------
source $VIMRUNTIME/vimrc_example.vim
let mapleader="," " <Leader>キー
set scrolloff=5 " スクロール時の余白確保
set textwidth=0 " 自動で折り返しをしない
set autoread " 自動読み直し
set hidden " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start "バックスペースキーで削除できるものを指定
"set formatoptions=lmoq "テキスト整形オプション，マルチバイト系を追加
set vb t_vb= " ビープ音を鳴らさない
set browsedir=buffer " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set showcmd " コマンドをステータス行に表示
set showmode " 現在のモードを表示
set modelines=0 " モードラインは無効

"------------------------------------
" Show
"------------------------------------
set title " タイトルを表示する
set ruler " ルーラーを表示
set laststatus=2 " 常にステータラスラインを表示
set showmatch " 対応する括弧をハイライト
set number " 行番号表示
set list " 不可視文字表示
set listchars=tab:>\ ,extends:<
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=red guibg=darkgray
match ZenkakuSpace /　/
set cursorline " カーソル行をハイライト
set ttyfast " 高速ターミナル接続を行う

"------------------------------------
" Color
"------------------------------------
syntax enable " ハイライト on
colorscheme morning " colorscheme

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

"------------------------------------
" Indentation
"------------------------------------
set autoindent " 自動でインデント
set smartindent " 新しい行のインデントを現在行と同じ数に
"set smarttab

if has("autocmd")
autocmd FileType * set formatoptions-=ro " 改行時にコメントしない

" expandtab = et タブ文字を空白に展開する
" tabstop = ts ファイル内の <Tab> が対応する空白の数
" softtabstop = sts タブキーを押したときに挿入される空白の量
" shiftwidth = sw 自動インデントの各段階に使われる空白の数

autocmd FileType php setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd FileType c setlocal ts=4 sw=4 noexpandtab cindent
autocmd FileType java setlocal ts=4 sts=4 sw=4 et
autocmd FileType sh setlocal ts=2 sts=2 sw=2 et
autocmd FileType sql setlocal ts=2 sts=2 sw=2 et
autocmd FileType scss setlocal ts=2 sts=2 sw=2 et
autocmd FileType coffee setlocal ts=2 sts=2 sw=2 et nowrap
autocmd FileType html,xhtml,css,javascript setlocal ts=2 sts=2 sw=2 et

autocmd BufNewFile,BufRead *.html setlocal ft=xhtml
autocmd BufNewFile,BufRead *.scss setlocal ft=scss
autocmd BufRead,BufNewFile *.coffee setlocal ft=coffee
autocmd BufNewFile,BufRead *.sass setfiletype sass

autocmd Filetype rst setlocal ts=8 sts=0 sw=2 et fenc=utf-8
autocmd Filetype scheme setlocal ts=8 sts=0 sw=2 et fenc=utf-8

" for rails
autocmd BufNewFile,BufRead app/*/*.erb setlocal ft=eruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb setlocal ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml setlocal ft=ruby fenc=utf-8
autocmd FileType ruby,haml,eruby,sass,cucumber,mason setlocal ts=2 sts=2 sw=2 et nowrap

"autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
endif


"------------------------------------
" Search
"------------------------------------
set incsearch " インクリメンタルサーチ
set ignorecase " 大文字小文字無視
set smartcase " 大文字は区別する
set hlsearch " 検索文字をハイライト
nmap \q :nohlsearch<CR>

"------------------------------------
" Complete
"------------------------------------
set wildmenu " コマンド補完を強化
set wildchar=<tab> " コマンド補完開始キー
set wildmode=list:longest " リスト表示
set history=1000 " コマンド・検索パターン履歴数
"set complete+=k " 補完に辞書ファイル追加

"------------------------------------
" Buffer
"------------------------------------
noremap <Space> :bn!<CR>
noremap <S-Space> :bp!<CR>
:com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn " ウィンドウレイアウトを崩さないでバッファを閉じる

"------------------------------------
" Autosave
"------------------------------------

let g:auto_save = 1

"ChangeLog
let g:changelog_username = "KUWASHIMA Yuichiro"

"Iinput method
let IM_CtrlMode = 4
if has('gui_running')
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
endif
set cmdheight=2
let IM_CtrlBufLocalMode = 1


"Session auto save/restore
augroup SessionAutocommands
  autocmd!

  autocmd VimEnter * nested call <SID>RestoreSessionWithConfirm()
  autocmd VimLeave * execute 'SaveSession'
augroup END

command! RestoreSession :source ~/.vim/.session
command! SaveSession    :mksession! ~/.vim/.session

" Restore session with confirm
function! s:RestoreSessionWithConfirm()
  let msg = 'Do you want to restore previous session?'

  if !argc() && confirm(msg, "&Yes\n&No", 1, 'Question') == 1
    execute 'RestoreSession'
  endif
endfunction
