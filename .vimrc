" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
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

set number
set foldmethod=indent

nnoremap ZZ :wqa<CR>
nnoremap <silent> <C-l> :nohlsearch<CR><C-l> 
nnoremap <F2> :%s/<C-r><C-w>//g<Left><Left>

inoremap kk <ESC>
inoremap <C-BS> <C-o>db

nnoremap <C-=><C-=> <C-r>=

vmap Y "+y
vnoremap <C-/><C-/> 0<C-q><S-i>#<Esc>
vnoremap <F2> :s/<C-r><C-w>//g<Left><Left>

abbr rpint print
abbr pirint print
abbr slef self
abbr sefl self
abbr supre super

set guifont=Inconsolata\ 12
colorscheme desert

" by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2
set mouse=a

augroup keys1
	autocmd!
	" for .ino files
	autocmd BufEnter *.py noremap <F5> :wa<CR>:tab terminal ./venv/bin/python3 %:p<CR>
	autocmd BufEnter *.py noremap <S-F5> :wa<CR>:tab terminal ./venv/bin/python3 %:p 
	autocmd BufEnter *.py noremap <F6> :tab terminal ./venv/bin/python3 -m pydoc <C-r><C-a>

	autocmd BufRead,BufNewFile text setlocal ts=4 sw=4 expandtab

augroup END

augroup keys2
	autocmd!

	autocmd BufEnter *.sh noremap <F5> :wa<CR>:tab terminal %:p<CR>
	autocmd BufEnter *.sh noremap <S-F5> :wa<CR>:tab terminal %:p 

	autocmd BufRead,BufNewFile text setlocal ts=4 sw=4 expandtab

augroup END

set backup
if !isdirectory($HOME."/.vim")
	silent! execute "!mkdir ~/.vim/"
endif

if !isdirectory($HOME."/.vim/bkp")
	silent! execute "!mkdir ~/.vim/bkp"
endif

if !isdirectory($HOME."/.vim/tmp")
	silent! execute "!mkdir ~/.vim/tmp"
endif

if !isdirectory($HOME."/.vim/undo")
	silent! execute "!mkdir ~/.vim/undo"
endif

set backupdir=$HOME/.vim/bkp
set directory=$HOME/.vim/tmp
set undodir=$HOME/.vim/undo
