" Configuration options

if !exists('g:persistent_scratch_file_location')
    let g:scratch_file_location = "/tmp/scratch"
endif
if !exists('g:persistent_scratch_file_ts_format')
    let g:persistent_scratch_file_ts_format = "%Y-%m-%d-%H-%M-%S"
endif
if !exists('g:persistent_scratch_default_file_ext')
    let g:persistent_scratch_default_file_ext = "md"
endif

" Helper functions
function! s:get_file_name(arguments)
    let l:file_stub = len(a:arguments) >= 1 ? printf("-%s", a:arguments[0]) : ""
    let l:file_ext = len(a:arguments) >= 2 ? a:arguments[1] : g:persistent_scratch_default_file_ext
    let l:file_ts = strftime(g:persistent_scratch_file_ts_format)
    call mkdir(g:scratch_file_location, 'p')
    return printf("%s/%s%s.%s", g:scratch_file_location, l:file_ts, l:file_stub, l:file_ext)
endfunction

function! s:save_current_buffer()
    silent execute "write!"
    return
endfunction

function! s:save_persistent_scratch(file_name)
    silent exe "write! " . a:file_name
    return
endfunction

function! s:persistent_scratch_write(args)
    let l:file_name = s:get_file_name(a:args)
    echo l:file_name
    call s:save_current_buffer()
    call s:save_persistent_scratch(l:file_name)
    return l:file_name
endfunction

" Plugin functions
function! persistent_scratch#write(...)
    let l:file_name = s:persistent_scratch_write(a:000)
    echohl "Saved to persistent scratch file " . l:file_name
endfunction

function! persistent_scratch#edit(...)
    let l:file_name = s:persistent_scratch_write(a:000)
    let cursor = getcurpos()
    let lnum = cursor[1]
    execute "edit " . "+" . lnum . " " . l:file_name
endfunction

" TODO(icyflame): Include the range keyword here function name(...) range {...}
" so that the highlighted range is then copied into the new scratch file.
"
" This function can be used to get the selection from the current buffer and
" pasting it into the new buffer: https://git.io/Jex4M