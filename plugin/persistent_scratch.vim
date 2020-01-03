" plugin/persistent_scratch.vim

if (exists('g:persistent_scratch_disable') && g:persistent_scratch_disable)
  finish
endif

command! -nargs=* -range=% PersistentScratchWrite call persistent_scratch#write(<line1>, <line2>, <f-args>)
command! -nargs=* -range=% PersistentScratchEdit call persistent_scratch#edit(<line1>, <line2>, <f-args>)
command! -nargs=1 PersistentScratchRead call persistent_scratch#read(<f-args>)

cnoreabbrev SCW PersistentScratchWrite
cnoreabbrev SCE PersistentScratchEdit
cnoreabbrev SCR PersistentScratchRead
