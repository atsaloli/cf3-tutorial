#!/bin/sh
#
# Run this shell script on your Hub VM to add Neil Watson's
# CFEngine 3 syntax highlighter (minus folding and keyword
# abbreviations) to your .vimrc


cat <<EOF >> $HOME/.vimrc

" -------- start of  .vimrc settings from Vertical Sysadmin
" training examples collection
"
" Neil Watson recommends installing functions Getchar and Eatchar for his CF3
" Syntax Highlighter
"
" function Getchar
fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun

" function Eatchar
fun! Eatchar(pat)
  let c = Getchar()
  return (c =~ a:pat) ? '' : c
endfun

" Syntax highlighting for CFEngine 3
filetype plugin on
syntax enable
au BufRead,BufNewFile *.cf set ft=cf3

" Disable folding so it does not confuse students not familiar with it
if exists("&foldenable")
	set nofoldenable 
endif

" disable abbreviations so it does not confuse students not familiar with it
let g:DisableCFE3KeywordAbbreviations=0

" -------- end of .vimrc settings from Vertical Sysadmin training examples
" collection
EOF

echo Downloading and installing vim editor plugin for CFEngine syntax\
 highlighting

mkdir -p ~/.vim/ftplugin  ~/.vim/syntax 

wget -O ~/.vim/syntax/cf3.vim \
      https://github.com/neilhwatson/vim_cf3/raw/master/syntax/cf3.vim

wget -O ~/.vim/ftplugin/cf3.vim \
      https://github.com/neilhwatson/vim_cf3/raw/master/ftplugin/cf3.vim
