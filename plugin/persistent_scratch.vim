" plugin/persistent_scratch.vim

if (exists('g:persistent_scratch_disable') && g:persistent_scratch_disable) || &compatible
  finish
endif

command! -nargs=* PersistentScratchWrite call persistent_scratch#write(<f-args>)
command! -nargs=* PersistentScratchEdit call persistent_scratch#edit(<f-args>)
command! -nargs=1 PersistentScratchRead call persistent_scratch#read(<f-args>)

cnoreabbrev SCW PersistentScratchWrite
cnoreabbrev SCE PersistentScratchEdit
cnoreabbrev SCR PersistentScratchRead
