" Configuration options
if !exists('g:persistent_scratch_file_location')
    let g:persistent_scratch_file_location = "/tmp/scratch"
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
    " TODO(icyflame): Make directory not in `pwd` but at home. This didn't work
    " properly if the location starts with ~ or with $HOME
    " call mkdir(g:persistent_scratch_file_location, 'p')
    return printf("%s/%s%s.%s", g:persistent_scratch_file_location, l:file_ts, l:file_stub, l:file_ext)
endfunction

function! s:save_current_buffer()
    silent execute "write!"
    return
endfunction

function! s:save_persistent_scratch(start, end, file_name)
    silent exe "" . a:start . "," . a:end . "write! " . a:file_name
    return
endfunction

function! s:persistent_scratch_write(start, end, args)
    let l:file_name = s:get_file_name(a:args)
    echo l:file_name

    try
        call s:save_current_buffer()
    catch
    finally
        call s:save_persistent_scratch(a:start, a:end, l:file_name)
    endtry

    return l:file_name
endfunction

" Plugin functions
function! persistent_scratch#write(start, end, ...) range
    let l:file_name = s:persistent_scratch_write(a:start, a:end, a:000)
    echohl "Saved to persistent scratch file " . l:file_name
endfunction

function! persistent_scratch#edit(start, end, ...) range
    let l:file_name = s:persistent_scratch_write(a:start, a:end, a:000)
    let cursor = getcurpos()
    let lnum = cursor[1]
    execute "edit " . "+" . lnum . " " . l:file_name
endfunction

function persistent_scratch#read(file_name_pat)
    let l:file_list = systemlist(printf('ls -1 %s', g:persistent_scratch_file_location))
    let l:matched = match(l:file_list, a:file_name_pat)

    if l:matched < 0
        throw 'None of the files in ' . g:persistent_scratch_file_location . ' matched the given pattern: ' . a:file_name_pat
        return 42
    endif

    let l:matched_file = l:file_list[l:matched]
    execute "edit " . printf("%s/%s", g:persistent_scratch_file_location, l:matched_file)
endfunction
