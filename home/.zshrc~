" vimrc

set nocompatible



set ignorecase
set smartcase

" to scroll and use the mouse
" set mouse=a

set modelines=1
set viminfo='20,\"50
set history=50
set ruler
set laststatus=2
set statusline=%<%F\ %h%m%r%=%-14.(%l--%c%V%)\ %P
set ts=3

set wildmode=list:longest

set background=dark "darkslategray
colorscheme evening

syntax on
filetype plugin on
filetype indent on

set hlsearch
set incsearch

set hlsearch
set incsearch
set smartindent
set backspace=2
set tabstop=3

set wrap

" set expandtab
set shiftwidth=3


" to ignore whitespaces in diff mode
map <C-B> :set diffopt+=iwhite<CR>
imap <C-B> <ESC>:set diffopt+=iwhite<CR>i<CR>

""------------------------------------------------
function! SwitchSourceHeader() 
"update! 
if (expand ("%:t") == expand ("%:t:r") . ".cc") 
  find %:t:r.hh 
else 
  find %:t:r.cc 
endif 
endfunction 

nmap ,h :call SwitchSourceHeader()<CR>
nmap ,s :sp <CR> :call SwitchSourceHeader()<CR>
nmap ,v :vs <CR> :call SwitchSourceHeader()<CR>
""------------------------------------------------

map <C-t> :tabnew<CR>
imap <C-t> <ESC>:tabnew<CR>
map <tab> :tabnext<CR>
map <S-tab> :tabprevious<CR>


""------------------------------------------------
set path=.,/usr/include/,/usr/local/include/,
set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,

set notagbsearch

set complete=.,d,i,b,w,t,u,]
" ----------------------------------------------------
" gestion de la completion
" ----------------------------------------------------

" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let OmniCpp_NamespaceSearch = 2

" function Tuttut()
"         return "salut"
" endfunction
" 
" map ,k :let current_reg=omni#cpp#utils#GetTypeInfoUntilWord()<CR>ea<C-R>=current_reg<CR><Esc>
" map ,j :let current_reg=Tuttut()<CR>i<C-R>=current_reg<CR><Esc>
" 

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" In text files, always limit the width of text to 78 characters
	autocmd BufRead *.txt set tw=78

	augroup cprog
		" Remove all cprog autocommands
		au!

		" When starting to edit a file:
		"   For C and C++ files set formatting of comments and set C-indenting on.
		"   For other files switch it off.
		"   Don't change the order, it's important that the line with * comes first.
		autocmd FileType *      set formatoptions=tcql nocindent comments&
		autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
	augroup END

	augroup gzip
		" Remove all gzip autocommands
		au!

		" Enable editing of gzipped files
		" set binary mode before reading the file
		autocmd BufReadPre,FileReadPre	*.gz,*.bz2 set bin
		autocmd BufReadPost,FileReadPost	*.gz call GZIP_read("gunzip")
		autocmd BufReadPost,FileReadPost	*.bz2 call GZIP_read("bunzip2")
		autocmd BufWritePost,FileWritePost	*.gz call GZIP_write("gzip")
		autocmd BufWritePost,FileWritePost	*.bz2 call GZIP_write("bzip2")
		autocmd FileAppendPre			*.gz call GZIP_appre("gunzip")
		autocmd FileAppendPre			*.bz2 call GZIP_appre("bunzip2")
		autocmd FileAppendPost		*.gz call GZIP_write("gzip")
		autocmd FileAppendPost		*.bz2 call GZIP_write("bzip2")

		" After reading compressed file: Uncompress text in buffer with "cmd"
		fun! GZIP_read(cmd)
			" set 'cmdheight' to two, to avoid the hit-return prompt
			let ch_save = &ch
			set ch=3
			" when filtering the whole buffer, it will become empty
			let empty = line("'[") == 1 && line("']") == line("$")
			let tmp = tempname()
			let tmpe = tmp . "." . expand("<afile>:e")
			" write the just read lines to a temp file "'[,']w tmp.gz"
			execute "'[,']w " . tmpe
			" uncompress the temp file "!gunzip tmp.gz"
			execute "!" . a:cmd . " " . tmpe
			" delete the compressed lines
			'[,']d
			" read in the uncompressed lines "'[-1r tmp"
			set nobin
			execute "'[-1r " . tmp
			" if buffer became empty, delete trailing blank line
			if empty
				normal Gdd''
			endif
			" delete the temp file
			call delete(tmp)
			let &ch = ch_save
			" When uncompressed the whole buffer, do autocommands
			if empty
				execute ":doautocmd BufReadPost " . expand("%:r")
			endif
		endfun

		" After writing compressed file: Compress written file with "cmd"
		fun! GZIP_write(cmd)
			if rename(expand("<afile>"), expand("<afile>:r")) == 0
				execute "!" . a:cmd . " <afile>:r"
			endif
		endfun

		" Before appending to compressed file: Uncompress file with "cmd"
		fun! GZIP_appre(cmd)
			execute "!" . a:cmd . " <afile>"
			call rename(expand("<afile>:r"), expand("<afile>"))
		endfun

	augroup END

	" This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
	" back to positions in previous files more than once.
	if 0
		" When editing a file, always jump to the last cursor position.
		" This must be after the uncompress commands.
		autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
	endif

endif " has("autocmd")

