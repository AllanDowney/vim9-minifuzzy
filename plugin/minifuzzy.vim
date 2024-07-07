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

if g:->get('minifuzzy_all_mapps', 1)
    nnoremap <C-p>      <Cmd>FzyFind<Space>PWD<CR>
    nnoremap <Leader>fb <Plug>(FzyBuffers)
    nnoremap <Leader>ff <Plug>(FzyFind)
    nnoremap <Leader>fg <Plug>(FzyGitFiles)
    nnoremap <Leader>fl <Plug>(FzyLines)
    nnoremap <Leader>fm <Plug>(FzyMRU)
endif

cnoremap <silent> <C-b>   <C-\>eminifuzzy#finders#StoreOldCmd()<CR><Esc>:FzyCommand<CR>
cnoremap <silent> <C-Tab> <C-\>eminifuzzy#finders#StoreOldCmd()<CR><Esc>:FzyCommand<CR>
