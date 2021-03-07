set expandtab
set shiftwidth=2
set laststatus=0
set nofoldenable
set number
imap <C-c> <Esc>
if !has('nvim')
  set viminfo+=n~/.vim/viminfo
endif
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
  augroup END
endif
syntax on
colorscheme onedark
