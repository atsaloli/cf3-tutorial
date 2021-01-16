#!/bin/sh
#
# Adds the following to your .vimrc:
# - "vim slideshow" keybindings
# - AsciiDoc syntax highlighter (the text portion of the "vim slideshow" is written in AsciiDoc) 


# First, install Neil Watson's cf3 syntax highlighter
ls ./100-180-Installing_Syntax_Highlighter-0265-Install_Vim_Plugin.sh
. ./100-180-Installing_Syntax_Highlighter-0265-Install_Vim_Plugin.sh

# Now, add the slideshow bindings
#
# Note: it has to be in that order (cf3 syntax highligter first).
# if you put the cf3 syntax highlighter below this section, it mucks up
# the mdless colorization of headings for some reason
cat <<EOF >> $HOME/.vimrc

" ---- Start of mappings to support the Training Examples aka "vim slideshow"

" use SPACE/F7 and BACKSPACE to control the run_slides.sh slideshow (move
" forwards and backwards)
" Note: at first, I used  <SPACE> and <BACKSPACE> but vim's pagination code
" that gets invoked after a command is run eats spaces (that's the 'press
" Enter to continue' prompt that vim gives you after running a command)
" so I added F7 as a workaround for that
map <F7> :next +1<CR>
map <SPACE> :next +1<CR>
map <BACKSPACE> :prev +1<CR>

" feed "f"ile to cf-agent in Inform mode -- used when we are looking
" at pygmentize output of cfengine policy source file, this allows us to run
" the policy source file in cf-agent
map ff :!clear;/var/cfengine/bin/cf-agent --color=always -KI -f '#:p'

" feed file to cf-agent in Verbose mode
map vv :!clear;/var/cfengine/bin/cf-agent --color=always -KIv -f '#:p' \| less -R

" "r"un file using /bin/sh
map rr :!clear;/bin/sh '#:p'

" Commenting out until
" https://vi.stackexchange.com/questions/28752/vim-terminal-interferes-with-statusline?noredirect=1#comment52552_28752
" is resolved
"
" Make status line visible
" set laststatus=2

" render markdown to "t"ext with mdless (see below)
" mdless is a markdown to text converter: https://brettterpstra.com/projects/mdless/
" Let's use it to render markdown formatting
" We use Vim "terminal" because it can handle the escape codes
" that mdless generates (it outputs color by default -- we could turn that off but
" it looks better with color).
" Install mdless with "gem install mdless" 
map tt :term++curwin mdless --no-pager --width=100 %:p

:autocmd BufRead *.md :term++curwin mdless --no-pager --width=100 %:p
:autocmd BufRead *.cf :term++curwin pygmentize -l cfengine3 %:p

" add a shortcut for "e"diting the previous file (alternate-file in Vim terminology).
" This lets us edit the source markdown/cfengine file.
" We have to add "noautocmd" to prevent Vim from rendering it with mdless/pygmentize
" as per the autocmds above.
map ee :noautocmd e #

function! CustomStatusline()
  " construct a custom statusline to show:
  " - the buffer number of the alternate file (we will have just ran mdless or
  "   pygmentize, so our buffer number will be different (higher)) -- i.e.,
  "   this will tell us the buffer number of the original
  "   file -- long story short, it gives us the file number, so we can tell
  "   how far into the collection we are.
  " - the total number of buffers (again, so we can tell where we are at -- e.g. 20 / 100)
  " - this Function will also label Exercises as such so I don't blow past them in class

  let current_buffer = bufnr('#')
  let total_buffers = len(getbufinfo({'buflisted':1}))
  let file_name = expand('%:t:r') " we'll use this to detect exercise files which are named *.exr.md (my own invention)
  let extension = expand('%:e') " this can detect *.cf files if we should want to do something with it
  if file_name =~ '^.*\.exr$'
    let label = '     ------------------ Exercise ----------------------'
    hi StatusLineTerm ctermbg=red ctermfg=black " change status bar color to something noticeable so exercises stand out
  else
    let label = ''
    hi StatusLineTerm ctermbg=black ctermfg=white " white on black background makes status bar less intrusive
  endif
  return current_buffer . '/' . total_buffers . label
endfunction

" Colorize status bar (to distinguish cf3, exercises and regular markdown files)
" Markdown: black on green
"au BufRead *.md hi StatusLine ctermbg=black ctermfg=green
"au BufRead *.md set laststatus=0
" display number of current buffer
" (https://stackoverflow.com/questions/5547943/display-number-of-current-buffer)
au BufRead *.md set laststatus=2 statusline=%{CustomStatusline()}

" CF3: black on yellow
"au BufRead *.cf hi StatusLine ctermbg=black ctermfg=yellow
"au BufRead *.cf set laststatus=0
"au BufRead *.cf set laststatus=2 statusline=%!bufnr('#')
" Exercises: black on red
"au BufRead *.exr.md hi StatusLine ctermbg=black ctermfg=red
au BufRead *.cf     set laststatus=2 statusline=%{CustomStatusline()}
au BufRead *.exr.md set laststatus=2 statusline=%{CustomStatusline()}

" Hide ~ marks that show past end of text (cosmetic change)
highlight EndOfBuffer ctermfg=black ctermbg=black
EOF
