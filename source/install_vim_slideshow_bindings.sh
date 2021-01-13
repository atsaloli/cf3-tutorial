#!/bin/sh
#
# Adds the following to your .vimrc:
# - "vim slideshow" keybindings
# - AsciiDoc syntax highlighter (the text portion of the "vim slideshow" is written in AsciiDoc) 


cat <<EOF >> $HOME/.vimrc


" The following are mappings to support the Training Examples "vim slideshow"

" use F7 and BACKSPACE to control the run_slides.sh slideshow (move
" forwards and backwards)
" Note: it used to be <SPACE> and <BACKSPACE> but vim's pagination code
" that gets invoked after a command is run eats spaces (that's the 'press
" Enter to continue' prompt that vim gives you after running a command)
map <F7> :next +1<CR>
map <SPACE> :next +1<CR>
map <BACKSPACE> :prev +1<CR>

" feed current "f"ile to cf-agent in Inform mode
map ff :!clear;/var/cfengine/bin/cf-agent --color=always -KI -f '%:p'

" feed current file to cf-agent in Verbose mode
map vv :!clear;/var/cfengine/bin/cf-agent --color=always -KIv -f '%:p' \| less -R

" "r"un current file using /bin/sh
map rr :!clear;/bin/sh '%:p'

" Binding to render "t"ext:
" run asciidoc to render AsciiDoc file; display it with elinks
" but filter out the Last-updated footer that elinks adds.
" Throw away warnings from asciidoc; some heading levels generate 
" warnings when processed standalone but they are needed for the
" compiled materials (in book form) to be more readable.
map tt :!clear;asciidoc -a source-highlighter=pygments -o - '%:p' 2>/dev/null \| elinks -dump -config-dir $HOME -config-file vsa-elinks.conf \| grep -v '^   Last updated '

" autocommand to render asciidoc files (*.txt) (should be the same as "tt" mapping above)
:autocmd BufRead *.txt :!clear; asciidoc -a source-highlighter=pygments -o - '%:p' 2>/dev/null  | elinks -dump -config-dir $HOME -config-file vsa-elinks.conf | grep -v '^   Last updated '

" Make status line visible
set laststatus=2

" Add file name to statusline so we know where we are in the slideshow
set statusline+=%f

" Syntax highlighting for AsciiDoc
autocmd BufRead,BufNewFile *.txt set ft=asciidoc

EOF
