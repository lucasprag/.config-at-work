" =============================================================================
" Name:          Not-a-vimmer
" File:          init.vim
" Description:   My simplified configs for Neovim.
" Author:        Lucas Arantes <lucasprag.com>
" =============================================================================


" PLUGINS ---------------------------------------------
call plug#begin('~/.config/nvim/plugged')

" > navigation
Plug 'easymotion/vim-easymotion' " makes a map to easy move the cursor
Plug 'terryma/vim-multiple-cursors' " multiple cursors using C-n when selecting a word

" > finding files/buffers/etc
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " presents the filesystem in the form of a tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " don't need to install fzf separately
Plug 'junegunn/fzf.vim' " search and open any file given a name
Plug 'Asheq/close-buffers.vim', { 'on': 'Bdelete' } " provides :Bdelete to close all, others or hidden buffers
Plug 'qpkorr/vim-bufkill' " :BB :BF, like :bb and bf but in the context of the window; BD to delete buffer and keep window

" > editing tools
Plug 'scrooloose/nerdcommenter' " comment code

" > ruby
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] } " ruby support
Plug 'sheerun/vim-haml', { 'for': 'haml' } " haml

" > elixir
Plug 'elixir-editors/vim-elixir', { 'for': ['elixir', 'eelixir'] } " syntax highlighting and filetype detection

" > javascript / typescript
Plug 'yuezk/vim-js', { 'for': 'javascript' }
Plug 'HerringtonDarkholme/yats.vim' " advanced typescript syntax highlighting
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'typescript'] }

" css
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' } " add syntax highlighting to code block on markdown files

" > git
Plug 'rhysd/committia.vim' " more pleasant editing on commit message

" > misc
Plug 'pbrisbin/vim-mkdir' " to create files without creating dirs previously (aka mkdir -p)
Plug 'tpope/vim-sensible' " better defaults
Plug 'vim-scripts/restore_view.vim' " restoring cursor position and folding
Plug 'liuchengxu/vim-which-key' " shows keybindings in popup when you press <leader>
Plug 'tpope/vim-endwise' " helps to end certain structures
Plug 'RRethy/vim-illuminate' " automatically highlight other uses of the current word under the cursor

" > style
Plug 'editorconfig/editorconfig-vim'

" > status line
Plug 'itchyny/lightline.vim' " really light and fast status line

Plug 'stephpy/vim-yaml', { 'for': ['yml', 'yaml'] } " yml, yaml
Plug 'dag/vim-fish', { 'for': 'fish' } " support for fish

" > colorschemes
Plug 'lucasprag/simpleblack'
Plug 'ayu-theme/ayu-vim'

call plug#end()


" COMMANDS --------------------------------------------

" I type so fast that :w becomes :W
command! W w
command! Q q
command! WQ wq
command! Wq wq
command! WQa wqa
command! Wqa wqa
command! WQA wqa
command! Q q
command! Qa qa
command! QA qa

" highlight trailing whitespace
" inspired on https://vi.stackexchange.com/questions/8563/toggle-highlighting-of-trailing-whitespace
let g:toggleHighlightWhitespace = 1
function! ToggleHighlightWhitespace() abort
  let g:toggleHighlightWhitespace = 1 - g:toggleHighlightWhitespace
  call RefreshHighlightWhitespace()
endfunction

function! RefreshHighlightWhitespace() abort
  if g:toggleHighlightWhitespace == 1 " normal action, do the hi
    highlight ExtraWhitespace ctermbg=white guibg=white
    match ExtraWhitespace /\s\+$/
    augroup HighLightWhitespace
      autocmd! BufWinEnter * match ExtraWhitespace /\s\+$/
      autocmd! InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
      autocmd! InsertLeave * match ExtraWhitespace /\s\+$/
      autocmd BufWinLeave * call clearmatches()
    augroup END
  else " clear whitespace highlighting
    "call clearmatches()
    autocmd! HighLightWhitespace BufWinEnter
    autocmd! HighLightWhitespace InsertEnter
    autocmd! HighLightWhitespace InsertLeave
    autocmd! HighLightWhitespace BufWinLeave
  endif
endfunction

autocmd! BufWinEnter,BufWinLeave * call RefreshHighlightWhitespace()

" > don't highlight trailing spaces for the whick_key buffer
autocmd! FileType which_key call ToggleHighlightWhitespace()
      \| autocmd BufLeave <buffer> call ToggleHighlightWhitespace()


" remove byebug, debugger, binding.pry, puts, console.log
" the _ is needed to avoid some waste of time http://vim.wikia.com/wiki/Power_of_g
command! RemoveDebuggers global/byebug\|debugger\|pry\|puts\|console.log/delete_

" remove trailing spaces
function! RemoveTrailingSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

command! RemoveTrailingSpaces :call RemoveTrailingSpaces()

" > hide which_key from statusline
autocmd! FileType which_key
autocmd! FileType which_key set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" > hide fzf from statusline
autocmd! FileType fzf
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" reload vim configuration (aka vimrc)
" :e reloads buffer to trigger the FileType event, useful if you don't want to put files into ftplugin
command! ReloadVimConfig so $MYVIMRC
  \| execute 'e'
  \| echo 'config reloaded!'


command! OpenVimConfig execute 'e ' $MYVIMRC

command! FormatElixirFile silent :!mix format %

" not sure why ftdetect doesn't work for vim-ember-hbs
autocmd BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=handlebars

" add some sort of highlighting to inky templates
autocmd BufNewFile,BufRead *.inky set filetype=html

function! ToggleLineNumbers()
  if &number == 1
    set nonumber
  else
    set number
  endif
endfunction

command! ToggleLineNumbers :call ToggleLineNumbers()

function! ToggleRelativeLineNumbers()
  if &relativenumber == 1
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

command! ToggleRelativeLineNumbers :call ToggleRelativeLineNumbers()

command! CopyFullPath let @+ = expand("%:p")
command! CopyRelativePath let @+ = expand("%")
command! CopyFileName let @+ = expand("%:t")

command! TurnOffSearchHighlight :set nohlsearch

" comment highlighting to json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Overwrite fzf's Files command to include a preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:80%'), <bang>0)

" Overwrite fzf's History command to include a preview
command! -bang History
  \ call fzf#vim#history(fzf#vim#with_preview('down:80%'))

" Rg with preview, toggle preview by pressing ?
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('down:80%', '?'),
  \   <bang>0)

" set spell checking for markdown files
autocmd BufNewFile,BufRead *.md setlocal spell

" command to be able to lazy load the plugin for easy swapping
 command! EasyWindowSwap :call WindowSwap#EasyWindowSwap()


 " CONFIGS ---------------------------------------------

" turns on "plugin" and "indent" at once
filetype indent plugin on

" break lines automaticaly when the reach the end of the window
set wrap

" don't show line numbers
set nonumber
set norelativenumber

" Show partial commands in the last line of the screen
set showcmd

" Always show the status line
set laststatus=2

" Don't need to show mode since status line also shows it
set noshowmode

" enable true colors support
set termguicolors

let ayucolor="dark"
colorscheme ayu
"colorscheme simpleblack

" Highlight searches
set hlsearch

" highlight dynamically as pattern is typed
set incsearch

" A guide column to keep the code to a maximum of 80 chars
set colorcolumn=120

" add some line space for easy reading
set linespace=2

" Use case insensitive search, except when using capital letters
set ignorecase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" " line of a window
set ruler

" Use visual bell instead of beeping when doing something wrong
set visualbell

" configs stolen from https://github.com/carlosantoniodasilva/vimfiles/blob/master/vimrc#L134
" Open new split panes to right and bottom, which feels more natural than vim’s default:
set splitbelow
set splitright

set wildignore=*.swp,*.bak,*.pyc,*.class,*.gif,*.png,*.jpg,*.jpeg,*.lock,*.temp,!*/

" > make which-key faster
set timeoutlen=300

" enable mouse, it's usuful sometimes
set mouse=a

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set ts=2 sw=2 sts=2
set expandtab

" Reload the file on changes
set autoread

"set fillchars=vert:\│,eob:\

" Makes the yank/past work in the X-server
" Ubuntu: it uses xclip
" OSX: it uses pbcopy/pbpaste
" See more details :help provider-clipboard
set clipboard=unnamedplus

" use both English and Portuguese when doing spell checking
set spelllang=en_us,pt_br

" make the editorconfig work using the external command
let g:EditorConfig_core_mode = 'external_command'

" height to the split for running specs
let g:VimuxHeight = "20"

" > NERDTree
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeShowLineNumbers=0
let NERDTreeWinSize=40

" disable default mappings from NERDCommenter, I just need to toggle it
let g:NERDCreateDefaultMappings = 0

" Align line-wise comment delimiters flush left instead of following code indentatio
let g:NERDDefaultAlign = 'left'

" don't comment empty lines
let g:NERDCommentEmptyLines = 0

" explorer
let g:netrw_liststyle=3

 " disable default mappings from easymotion
let g:EasyMotion_do_mapping = 0

" disable default bindings from vim-windowswap
let g:windowswap_map_keys = 0

" disable default mappings from vim-alchemist
let g:alchemist_mappings_disable = 1
let g:alchemist_tag_disable = 1

" enable fenced code block syntax highlighting in markdown files
let g:markdown_fenced_languages = ['ruby', 'elixir', 'javascript', 'html', 'python', 'bash=sh', 'vim', 'help', 'sql']

" make fzf a floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Todo' } }

" move search to the top of the window
let $FZF_DEFAULT_OPTS='--layout=reverse'

" don't need to create BufKill's default mappings
let g:BufKillCreateMappings = 0


" MAPPINGS --------------------------------------------
let mapleader = "\<Space>"

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

" b => buffers ----------
let g:which_key_map.b = { 'name': '+buffers' }
let g:which_key_map.b.a = [':Bdelete all', 'close all']
nmap ; :Buffers<CR>
let g:which_key_map.b.b = [':Buffers', 'buffers'] " list buffers
let g:which_key_map.b.d = [':BD', 'close'] " delete a buffer but keep its window
let g:which_key_map.b.o = [':Bdelete hidden', 'close others'] " close all buffers except buffer in current window
let g:which_key_map.b.w = [':bd', 'close window and buffer']

" goes to the previous/next buffer
nmap <S-h> :BB<CR>
nmap <S-l> :BF<CR>
let g:which_key_map.b.p = [':BB', 'previous']
let g:which_key_map.b.n = [':BF', 'next']

" c => code ----------
let g:which_key_map.c = { 'name': '+code' }
let g:which_key_map.c.c = ['<plug>NERDCommenterToggle', 'comment'] " toggle comment
let g:which_key_map.c[' '] = ['RemoveTrailingSpaces', 'remove trailing spaces']
let g:which_key_map.c.p = ['RemoveDebuggers', 'remove debuggers'] " remove byebug, debugger, etc
let g:which_key_map.c.t = ['Filetypes', 'change file type']

" f => file ----------
let g:which_key_map.f = { 'name': '+file' }
let g:which_key_map.f.f = ['CopyFullPath', 'copy full path']
let g:which_key_map.f.n = ['CopyFileName', 'copy file name']
let g:which_key_map.f.r = ['CopyRelativePath', 'copy relative path']
let g:which_key_map.f.m = ['Marks', 'marks']

" g => git ----------
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.g.s = [':GFiles?', 'status']

" j => jump ----------
let g:which_key_map.j = { 'name': '+jump' }
let g:which_key_map.j.l = ['<Plug>(easymotion-lineforward)', 'forward']
let g:which_key_map.j.j = ['<Plug>(easymotion-j)', 'down']
let g:which_key_map.j.k = ['<Plug>(easymotion-k)', 'up']
let g:which_key_map.j.h = ['<Plug>(easymotion-linebackward)', 'backward']

let g:which_key_map.j.f = ['<Plug>(easymotion-w)', 'forward/down']
let g:which_key_map.j.b = ['<Plug>(easymotion-b)', 'backward/up']

map f <Plug>(easymotion-lineforward)
map F <Plug>(easymotion-linebackward)

" p => project ----------
map <C-p> :Files<CR>

let g:which_key_map.p = { 'name': '+project' }
let g:which_key_map.p.f = ['Files', 'files'] " fuzzy find files
let g:which_key_map.p.t = ['NERDTreeToggle', 'tree'] " toggle nerdtree
let g:which_key_map.p.l = ['NERDTreeFind', 'locate on tree'] " locate file on nerdtree

" s => search----------
let g:which_key_map.s = { 'name': '+search' }
map s :Rg<CR>
let g:which_key_map.s.s = ['Rg', 'search'] " ALT-A + enter to copy everything to quickfix
let g:which_key_map.s.h = ['TurnOffSearchHighlight', 'turn off highlight']
nmap <C-f> :Filetypes<CR>
let g:which_key_map.s.f = ['Filetypes', 'filetypes'] " fuzzy search for file types and manually set it
map r :History<CR>
let g:which_key_map.s.r = ['History', 'recent files'] " open window to find recent files
let g:which_key_map.s.w = ['Windows', 'windows']

" TAB => tabs ----------
nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>
let g:which_key_map['<Tab>'] = { 'name': '+tabs' }
let g:which_key_map['<Tab>'].n = ['tabnew', 'new']
let g:which_key_map['<Tab>'].l = ['tabnext', 'next'] " next tab (hjkL)
let g:which_key_map['<Tab>'].h = ['tabprevious', 'previous'] " previous tab (Hjkl)
let g:which_key_map['<Tab>'].c = ['tabclose', 'close']

" T => toggles ----------
let g:which_key_map.T = { 'name': '+toggles' }
let g:which_key_map.T.c = [':Colors', 'colorschemes']
let g:which_key_map.T.n = [':ToggleLineNumbers', 'numbers']
let g:which_key_map.T.l = [':ToggleLineNumbers', 'line numbers'] " because I sometimes forgot that that map is SPC T n
let g:which_key_map.T.r = [':ToggleRelativeLineNumbers', 'relative numbers']
let g:which_key_map.T.m = [':messages', 'messages']

" v => vim ----------
let g:which_key_map.v = { 'name': '+vim' }
let g:which_key_map.v.c = ['OpenVimConfig', 'init.vim']
let g:which_key_map.v.r = ['ReloadVimConfig', 'reload']
let g:which_key_map.v.i = ['PlugInstall', 'install']
let g:which_key_map.v.u = ['PlugUpdate', 'update']
let g:which_key_map.v.k = ['PlugClean', 'clean']

" w => windows ----------
let g:which_key_map.w = { 'name': '+windows' }
let g:which_key_map.w.c = ['q', 'close']
let g:which_key_map.w.o = ['only', 'close others']
let g:which_key_map.w['-']  = ['split', 'split horizontally']
let g:which_key_map.w['/'] = ['vsplit', 'split vertically']
nmap <C-\> :vsplit<CR>

" ignore
let g:which_key_map.b.u = { 'name': 'which_key_ignore' }
let g:which_key_map.b.f = 'which_key_ignore'

let g:which_key_map.C = { 'name': 'which_key_ignore' }
let g:which_key_map.h = { 'name': 'which_key_ignore' }
let g:which_key_map['!'] = { 'name': 'which_key_ignore' }
" ----------------------------------------------

" Copy and cut an entire line to clipboard
vmap <C-c> :w !pbcopy<CR><CR>
vmap <C-x> :!pbcopy<CR>

" Save using Ctrl + s, ¯\_(ツ)_/¯
map <C-s> :w<CR>
map <C-q> :q<CR>
map <C-a> :wqa<CR>


" Disable cursor keys in normal mode, no idea how to use emojis
map <Left>  :echo "use h instead (hjkl)"<CR>
map <Right> :echo "use l instead (hjkl)"<CR>
map <Up>    :echo "use k instead (hjkl)"<CR>
map <Down>  :echo "use j instead (hjkl)"<CR>


" use Ctrl + hj to move lines
let g:move_key_modifier = 'C'

" move this away since I can't remove it, TODO: remove this plugin?
let g:table_mode_map_prefix = "<leader>C"


" STATUS LINE --------------------------------------------

" light line
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! g:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" colorschemes I like the most are jellybeans, seoul256 and simpleblack
let g:lightline = {
\ 'colorscheme': 'ayu_dark',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename']],
\   'right': [['lineinfo'], ['filetype'], ['readonly', 'modified']]
\ },
\ 'inactive': {
\   'left': [['filename']],
\   'right': [['lineinfo'], ['filetype']]
\ },
\ 'component_type': {
\   'readonly': 'error',
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename',
\ }
\ }

