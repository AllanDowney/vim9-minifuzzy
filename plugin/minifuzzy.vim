if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/minifuzzy/finders.vim"

if exists('g:loaded_minifuzzy')
	finish
endif

g:loaded_minifuzzy = 1

command! -nargs=* -complete=dir FzyFind finders.Find(<q-args>)
command! FzyBuffers                     finders.Buffers()
command! FzyMRU                         finders.MRU()
command! FzyLines                       finders.Lines()
command! FzyGitFiles                    finders.GitFiles()
command! FzyCommand                     finders.Command()

nnoremap <Plug>(FzyFind) <Cmd>FzyFind<CR>
nnoremap <Plug>(FzyBuffers) <Cmd>FzyBuffers<CR>
nnoremap <Plug>(FzyMRU) <Cmd>FzyMRU<CR>
nnoremap <Plug>(FzyLines) <Cmd>FzyLines<CR>
nnoremap <Plug>(FzyGitFiles) <Cmd>FzyGitFiles<CR>
nnoremap <Plug>(FzyCommand) <Cmd>FzyCommand<CR>

cnoremap <Plug>(FzyCmdComplete)  <C-\>eminifuzzy#finders#StoreOldCmd()<CR><Esc>:FzyCommand<CR>

if g:->get('minifuzzy_all_mapps', 1)
	if !hasmapto('<Plug>(FzyBuffers)', 'n')
		nnoremap <Leader>fb <Plug>(FzyBuffers)
	endif
	if !hasmapto('<Plug>(FzyCommand)', 'n')
		nnoremap <Leader>fc <Plug>(FzyCommand)
	endif
	if !hasmapto('<Plug>(FzyFind)', 'n')
		nnoremap <Leader>ff <Plug>(FzyFind)
	endif
	if !hasmapto('<Cmd>FzyFind<Space>1<CR>', 'n')
		nnoremap <Leader>f1 <Cmd>FzyFind<Space>1<CR>
	endif
	if !hasmapto('<Cmd>FzyFind<Space>2<CR>', 'n')
		nnoremap <Leader>f2 <Cmd>FzyFind<Space>2<CR>
	endif
	if !hasmapto('<Plug>(FzyGitFiles)', 'n')
		nnoremap <Leader>fg <Plug>(FzyGitFiles)
	endif
	if !hasmapto('<Plug>(FzyLines)', 'n')
		nnoremap <Leader>fl <Plug>(FzyLines)
	endif
	if !hasmapto('<Plug>(FzyMRU)', 'n')
		nnoremap <Leader>fm <Plug>(FzyMRU)
	endif
	if !hasmapto('<Plug>(FzyCmdComplete)', 'c')
		cnoremap <silent> <C-P>   <Plug>(FzyCmdComplete)
	endif
	if !hasmapto('<Plug>(FzyCmdComplete)', 'c')
		cnoremap <silent> <C-Tab> <Plug>(FzyCmdComplete)
	endif
endif

