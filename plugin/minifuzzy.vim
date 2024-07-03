if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/minifuzzy/finders.vim"

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
    nnoremap <C-p>      <Plug>(FzyFind)
    nnoremap <leader>fb <Plug>(FzyBuffers)
    nnoremap <leader>ff <Plug>(FzyFind)
    nnoremap <leader>fg <Plug>(FzyGitFiles)
    nnoremap <leader>fl <Plug>(FzyLines)
    nnoremap <leader>fm <Plug>(FzyMRU)
endif

cnoremap <silent> <C-b>   <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:FzyCommand<CR>
cnoremap <silent> <C-Tab> <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:FzyCommand<CR>
