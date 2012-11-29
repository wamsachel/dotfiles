"Turn line numbers on
set number

" Create a command that will write output and then open up a shell 
command Ws w | shell

" Swap ; and : to save from hitting shift in to enter a vim command
nore ; :
nore , ;

" Hitting ii in Insert mode will exit insert mode
imap ii <C-[>

" Highlight current line
set cul

" Turn on some command mode tab complete
set wildmenu
set wildmode=list:longest,full

" Highlight searched items
set hlsearch

" Inc search (search while typing in search item)
set incsearch


