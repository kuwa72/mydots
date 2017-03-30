 " Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

"dein Scripts-----------------------------
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/neomru.vim')

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

call dein#add('Shougo/vimshell')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('honza/vim-snippets')
" HTML input support. like CSS Selector.
call dein#add('rstacruz/sparkup', {'rtp': 'vim/'})
call dein#add('Shougo/vimfiler')
call dein#add('907th/vim-auto-save')
call dein#add('pangloss/vim-javascript')

if has('gui_running')
  call dein#add('fuenor/im_control.vim')
endif
" <Leader>[move] fast move method.
"call dein#add('Lokaltog/vim-easymotion')
" Git command wrapper
call dein#add('tpope/vim-fugitive')
call dein#add('L9')
" File open support
" call dein#add('FuzzyFinder')
" Read/Write remote file
call dein#add('netrw.vim')
" reStructuredText plugin
call dein#add('Rykka/riv.vim')

call dein#add('fuenor/JpFormat.vim')

call dein#add('h1mesuke/unite-outline')
call dein#add('StanAngeloff/php.vim')
call dein#add('kien/ctrlp.vim')
"call dein#add('snipMate')

call dein#add('iakio/smarty3')
let g:smarty_left_delimiter = '<!--{'
let g:smarty_right_delimiter = '}-->'

"colorschemes
" solarized
call dein#add('altercation/vim-colors-solarized')
" mustang
call dein#add('croaker/mustang-vim')
" jellybeans
call dein#add('nanotech/jellybeans.vim')
" molokai
call dein#add('tomasr/molokai')

call dein#add('ujihisa/unite-colorscheme')

call dein#add('bronson/vim-trailing-whitespace')

call dein#add('rking/ag.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('junegunn/vim-easy-align')

" " -- Clojure

call dein#add('kien/rainbow_parentheses.vim')
call dein#add('guns/vim-clojure-static')
call dein#add('guns/vim-sexp')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-fireplace')
call dein#add('tpope/vim-classpath')
call dein#add('tpope/vim-salve')
call dein#add('guns/vim-clojure-highlight')
call dein#add('scrooloose/nerdtree')
call dein#add('bling/vim-airline')
call dein#add('venantius/vim-eastwood')
call dein#add('scrooloose/syntastic')

call dein#add('Align')
call dein#add('SQLUtilities')

call dein#add('junegunn/vim-emoji')
call dein#add('DirDiff.vim')

call dein#add('supermomonga/shaberu.vim')

call dein#add('chazy/cscope_maps')

call dein#add('udalov/kotlin-vim')

call dein#add('nanotech/jellybeans.vim')
call dein#add('w0ng/vim-hybrid')
call dein#add('vim-scripts/twilight')
call dein#add('jonathanfilip/vim-lucius')
call dein#add('jpo/vim-railscasts-theme')
call dein#add('altercation/vim-colors-solarized')
call dein#add('vim-scripts/Wombat')
call dein#add('tomasr/molokai')
call dein#add('vim-scripts/rdark')

call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/tsuquyomi')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

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
let mapleader="\<Space>" " <Leader>キー
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
set ambiwidth=double "🍣

"------------------------------------
" Show
"------------------------------------
set title " タイトルを表示する
set ruler " ルーラーを表示
set laststatus=2 " 常にステータラスラインを表示
set showmatch " 対応する括弧をハイライト
"set number " 行番号表示
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
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif
syntax enable " ハイライト on
set background=dark
let g:solarized_termcolors=256
colorscheme  murphy "molokai  colorscheme


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

autocmd FileType smarty setlocal ts=4 sts=0 sw=4 expandtab
autocmd FileType php setlocal ts=4 sts=0 sw=4 expandtab
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

autocmd FileType smarty3 setlocal ts=4 sts=0 sw=4 expandtab
au BufRead,BufNewFile *.html set filetype=smarty3
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
noremap <Leader>n :bn!<CR>
noremap <Leader>p :bp!<CR>
:com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn " ウィンドウレイアウトを崩さないでバッファを閉じる


""""""""""" プラグインごとの設定 """""""""""{{{
" Unite起動時にインサートモードで開始
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g --silent""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" Uniteの各種ショートカット設定
" バッファ一覧
nnoremap <silent> ;ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ;uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ;ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ;um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ;ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" Ctrl +  o でタグアウトラインを表示
nnoremap <C-o> :<C-u>Unite outline<CR>

" search a file in the filetree
nnoremap <silent> ;ua :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <silent> ;ur <Plug>(unite_restart)

"}}}

"------------------------------------
" Autosave
"------------------------------------

let g:auto_save = 0

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


""""" PHP用設定 """"""""
" :makeでPHP構文チェック
au FileType php setlocal makeprg=php\ -l\ %
au FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
au FileType php setlocal foldmethod=manual

" PHPの関数やクラスの折りたたみ(非常に重い）
let php_folding = 0

" 文字列の中のSQLをハイライト
let php_sql_query = 1

" Baselibメソッドのハイライト
let php_baselib = 1

" HTMLもハイライト
let php_htmlInStrings = 1

" <? を無効にする→ハイライト除外にする
let php_noShortTags = 1

" ] や ) の対応エラーをハイライト
let php_parent_error_close = 1
let php_parent_error_open = 1


"}}}

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:sparkupNextMapping = '<c-_>'

"-- type ° to search the word in all files in the current dir
nmap <Leader>+ :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <Leader>/ :Ag

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" Clojure
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesActivate
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadRound
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadSquare
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadBraces
autocmd BufEnter *.cljs,*.clj,*.cljs.hl setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:
" -- Rainbow parenthesis options
let g:rbpt_colorpairs = [
    \ ['darkyellow',  'RoyalBlue3'],
    \ ['darkgreen',   'SeaGreen3'],
    \ ['darkcyan',    'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['DarkMagenta', 'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkyellow',  'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['DarkMagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkyellow',  'DarkOrchid3'],
    \ ['darkred',     'firebrick3'],
    \ ]
let g:sexp_enable_insert_mode_mappings = 0

silent! if emoji#available()
	let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
	let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
	let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
	let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

nmap <C-h> :Doc <c-r>=expand("<cword>")<cr><cr>
nmap <C-e> :Eval<cr>

set ambiwidth=double

set rtp+=/usr/local/opt/fzf

