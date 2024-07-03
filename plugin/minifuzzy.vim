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

nnoremap <leader>ff <Cmd>FzyFind<CR>
nnoremap <C-p>      <Cmd>FzyFind<CR>
nnoremap <leader>fb <Cmd>FzyBuffers<CR>
nnoremap <leader>fm <Cmd>FzyMRU<CR>
nnoremap <leader>fl <Cmd>FzyLines<CR>
nnoremap <leader>fg <Cmd>FzyGitFiles<CR>

cnoremap <silent> <C-b>   <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:MinifuzzyCommand<CR>
cnoremap <silent> <C-Tab> <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:MinifuzzyCommand<CR>
