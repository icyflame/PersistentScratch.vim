" plugin/persistent_scratch.vim
"
echo "Loading persistent_scratch"

if (exists('g:persistent_scratch_disable') && g:persistent_scratch_disable) || &compatible
  finish
endif

command! -nargs=* PersistentScratchWrite call persistent_scratch#write(<f-args>)
command! -nargs=* PersistentScratchEdit call persistent_scratch#edit(<f-args>)

cnoreabbrev SCW PersistentScratchWrite
cnoreabbrev SCE PersistentScratchEdit

" command! -bang -nargs=0 persistent_scratch call persistent_scratch#open(<bang>0)
" command! -bang -nargs=0 persistent_scratchInsert call persistent_scratch#insert(<bang>0)
" command! -bang -nargs=0 -range persistent_scratchSelection call persistent_scratch#selection(<bang>0)
" command! -nargs=0 persistent_scratchPreview call persistent_scratch#preview()
"
" nnoremap <silent> <plug>(persistent_scratch-insert-reuse) :call persistent_scratch#insert(0)<cr>
" nnoremap <silent> <plug>(persistent_scratch-insert-clear) :call persistent_scratch#insert(1)<cr>
" xnoremap <silent> <plug>(persistent_scratch-selection-reuse) :<c-u>call persistent_scratch#selection(0)<cr>
" xnoremap <silent> <plug>(persistent_scratch-selection-clear) :<c-u>call persistent_scratch#selection(1)<cr>
"
" if !exists('g:persistent_scratch_no_mappings')
  " nmap gs <plug>(persistent_scratch-insert-reuse)
  " nmap gS <plug>(persistent_scratch-insert-clear)
  " xmap gs <plug>(persistent_scratch-selection-reuse)
  " xmap gS <plug>(persistent_scratch-selection-clear)
  " nnoremap gZzZz gs
" endif
