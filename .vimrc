if 1
 filetype plugin indent off

 "--------------------------------------------------
 " Start Neobundle Settings.
 "--------------------------------------------------

 if has('vim_starting')
   set nocompatible
   if !isdirectory(expand("~/.vim/bundle/neobundle.vim"))
     echo "install neobundle..."
     :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
   endif
   set runtimepath+=~/.vim/bundle/neobundle.vim
 endif
 call neobundle#rc(expand('~/.vim/bundle/'))
 call neobundle#begin(expand('~/.vim/bundle/'))

 NeoBundleFetch 'git://github.com/Shougo/neobundle.vim'

 NeoBundle 'git://github.com/Shougo/neocomplcache.git' "auto complete
 NeoBundle 'git://github.com/Shougo/neosnippet.git' "auto snippet
 NeoBundle 'git://github.com/Shougo/neosnippet-snippets.git' "snippet files

 NeoBundle 'git://github.com/Shougo/unite.vim' "user interface for vim
 NeoBundle 'git://github.com/scrooloose/nerdtree.git' "filer
 NeoBundle 'git://github.com/sjl/gundo.vim.git' "undo tree
 NeoBundle 'git://github.com/vim-scripts/YankRing.vim' "managemaent yank history
 NeoBundle 'git://github.com/Lokaltog/vim-easymotion.git' "speed up move cursor

 NeoBundle 'git://github.com/scrooloose/nerdcommenter.git' "comment out plugin
 NeoBundle 'git://github.com/kana/vim-smartchr.git' "using operator plugin
 NeoBundle 'git://github.com/tpope/vim-surround.git' "surround parentheses
 NeoBundle 'git://github.com/Raimondi/delimitMate.git' "generate paretheses
 NeoBundle 'git://github.com/altercation/vim-colors-solarized.git' "color schema

 NeoBundle 'git://github.com/Lokaltog/vim-powerline.git' "powerline

 NeoBundle 'git://github.com/thinca/vim-quickrun.git' "quick run

 call neobundle#end()

 filetype plugin indent on

 NeoBundleCheck

 "--------------------------------------------------
 " Default settings.
 "--------------------------------------------------
 "
 " For back up
 "
 " unset back up
 set nobackup
 " If rewrite case, back up before rewrite.
 " (backup is not on, remove back up after rewrite)
 set writebackup
 " leave 1000 histories.
 set history=1000
 " do not distinguish Capital and Child character in search
 set ignorecase
 " If mix Capital and Child character in search, distinguish
 set smartcase
 " return Beginning after search
 set wrapscan
 " incremental search
 set incsearch
 " push esc is hilight off
 nnoremap <silent> <ESC><ESC> :noh<CR>
 "
 " For display
 "
 " display title
 set title
 " display line number
 set number
 " display command on status line
 set showcmd
 " display status line, always!
 set laststatus=2
 " display status line configuration
 set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
 highlight StatusLine	term=NONE cterm=NONE ctermfg=black ctermbg=white
 " display corresponding parentheses
 set showmatch
 set matchtime=2
 " sytax highlight is enable
 syntax on
 " highlight is enable in search
 set hlsearch
 " custom command line supplement
 set wildmenu
 " text width
 set textwidth=0
 " wrap is on
 set wrap
 " display double-byte space
 highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=drakgray
 match ZenkakuSpace /　/
 "
 " For indent
 "
 " disable auto indent
 set noautoindent
 " tab is four space
 set tabstop=4
 " replace tab to space
 set softtabstop=4
 " indent is four space
 set shiftwidth=4
 "
 " For auto command
 "
 if has('autocmd')
	 " index, plugin is enable
	 filetype plugin indent on
	 " store cursor position
	 autocmd BufReadPost *
	 	\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
	 	\ endif
 endif

 function! s:remove_dust()
	 let cursor = getpos(".")
	 " remove space of end of line in save
	 %s/\s\+$//ge
	 " replace tab to two space in save
	 %s/\t/	/ge
	 call setpos(".", cursor)
	 unlet cursor
 endfunction
 autocmd BufWritePre * call <SID>remove_dust()
 "
 " For move
 "
 " move in insert mode
 inoremap <C-p> <Up>
 inoremap <C-n> <Down>
 inoremap <C-b> <Left>
 inoremap <C-f> <Right>
 inoremap <C-e> <End>
 inoremap <C-a> <Home>
 inoremap <C-h> <Backspace>
 inoremap <C-d> <Del>
 "
 " Other
 "
 " If switch buffer, do not lose undo
 set hidden
 " do not display start up message
 set shortmess+=I
 " support screen
 set ttymouse=xterm2


 "--------------------------------------------------
 " neocomplcache
 "--------------------------------------------------
 " Use neocomplcache
 let g:neocomplcache_enable_at_startup = 1
 " Use smartcase
 let g:neocomplcache_enable_smart_case = 1
 " Use camel case completion.
 let g:neocomplcache_enable_camel_case_completion = 1
 " Use undarbar completion.
 let g:neocomplcache_enable_underbar_completion = 1
 " Pugin key mappings.
 inoremap <expr><C-g>	neocomplcache#undo_completion()
 inoremap <expr><C-l>	neocomplcache#complete_common_string()
 " <CR>: close popup and save indent
 inoremap <expr><CR>	neocomplcache#smart_close_popup(). "\<CR>"
 " <TAB>: completion.
 inoremap <expr><TAB>	pumvisible() ? "\<C-n>" : "\<TAB>"
 " <C-h>, <BS>: close popup and delete backword char.
 inoremap <expr><C-h>	neocomplcache#smart_close_popup()."\<C-h>"
 inoremap <expr><BS>	neocomplcache#smart_close_popup()."\<C-h>"
 inoremap <expr><C-y>	neocomplcache#close_popup()

 "--------------------------------------------------
 " neosnippet
 "--------------------------------------------------
 " Plugin key-mappings.
 imap <C-k>	<Plug>(neosnippet_expand_or_jump)
 smap <C-k>	<Plug>(neosnippet_expand_or_jump)
 xmap <C-k>	<Plug>(neosnippet_expand_target)

 "SuperTab like snippets behavior
 imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			 \ "\<Plug>(neosnippet_expand_or_jump)"
			 \: pumvisible() ? "\<C-n>" : "\<TAB>"
 smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			 \ "\<Plug>(neosnippet_expand_or_jump)"
			 \: "\<TAB>"

 "For snippet complete marker.
 if has('conceal')
	 set conceallevel=2 concealcursor=i
 endif
 " Enable snipMate compatibility feature.
 let g:neosnippet#enable_snipmate_compatibility = 1
 " location of snippets
 let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets/'


 "--------------------------------------------------
 " YankRing
 "--------------------------------------------------
 let g:yankring_manual_clipboard_check = 0

 "--------------------------------------------------
 " delimitMate
 "--------------------------------------------------
 inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
			 \ "\<CR>=delimitMate#ExpandReturn()\<CR>" :
			 \ "<CR>"
 let g:delimitMate_expand_cr = 1

 "--------------------------------------------------
 " smartchr
 "--------------------------------------------------
 inoremap <expr> + smartchr#one_of(' + ', '++', '+')
 inoremap <expr> - smartchr#one_of(' - ', '--', '-')
 inoremap <expr> , smartchr#one_of(', ', ',')
 inoremap <expr> : smartchr#one_of(': ', ':')
 inoremap <expr> ; smartchr#one_of(';', ';<cr>')

endif

