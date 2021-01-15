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

" Make status line visible
set laststatus=2

" Add file name to statusline so we know where we are in the slideshow
set statusline+=%f

" Syntax highlighting for AsciiDoc
autocmd BufRead,BufNewFile *.txt set ft=asciidoc

" render markdown to "t"ext with mdless (see below)
map tt :term++curwin mdless --no-pager %:p

" mdless is a markdown to text converter: https://brettterpstra.com/projects/mdless/
" Let's use it to render markdown formatting
" We use Vim "terminal" because it can handle the escape codes
" that mdless generates (it outputs color by default -- we could turn that off but
" it looks better with color).
" Install mdless with "gem install mdless" 
:autocmd BufRead *.md :term++curwin mdless --no-pager --width=80 %:p
:autocmd BufRead *.cf :term++curwin pygmentize -l cfengine3 %:p

" add a shortcut for "e"diting the previous file (alternate-file in Vim terminology).
" This lets us edit the source markdown file.
" We have to add "noautocmd" to prevent Vim from rendering it with mdless
" as per the autocmd above.
map ee :noautocmd e #
" Colorize status bar (for working on cf3-tutorial)
" Markdown: black on green
au BufRead *.md hi StatusLine ctermbg=black ctermfg=green
" CF3: black on yellow
au BufRead *.cf hi StatusLine ctermbg=black ctermfg=yellow
" Exercises: black on red
au BufRead *.exr.md hi StatusLine ctermbg=black ctermfg=red
EOF
