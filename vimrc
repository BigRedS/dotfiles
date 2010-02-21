syntax on		" syntax highlighting
set nowrap		" No auto linewrapping
set number		" Show line numbers
set numberwidth=3	" Minimum of three columns for line numbers
set background=dark	" Light-coloured text
set ai			" Autoindent
set smartindent		" Smart Auto Indent
set ls=2		" Always show status line
set scrolloff=5		" Keep 5 lines when scrolling
set title		" Show title in console title bar
set cmdheight=2		" Command window height
set ignorecase		" Case-insensitive search...
set smartcase		" ... except when there's a captial letter in the search string
set pastetoggle=<F12>	" Toggle between 'paste' and 'nopaste'

" Run perl script:
map <F5> :!perl % <CR>
" check perl syntax of script:
map <F6> :!perl -c % <CR>

" Indent and unindent lines:
map <F3> :s/^/\t/<CR>
map <F4> :s/^\t//<CR>

" Comment and uncomment lines:
map <F7> :s/^/#/<CR>	
map <F8> :s/^#//<CR>	

map <F9> :s/^/\/\//<CR>
map <F10> :s/^\/\///<CR>
