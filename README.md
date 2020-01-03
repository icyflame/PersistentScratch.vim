# PersistentScratch.vim

> Store your scratch files in persistent storage

## Why?

Often, I have wanted to store text in a file without thinking much about the
file name or where it is stored. The text in this file is essentially scratch
text but I want to have it stored in persistent storage, on the off chance that
I need it later. I started with a few [Bash functions][1] which created these files
and named them appropriately.

This worked fine as long as I didn't have to open the file back up or create the
file from inside vim itself. This Vim plugin saves the current buffer into a
persistent scratch file at a location that can be configured. It tries to
minimize the steps between wanting to store a file and storing a file in
persistent storage. Everything is pre-configured or optional.

## Commands

### `:SCW [stub] [extension]`

> Write the current buffer to a scratch file whose name will have the stub and
> whose extension will be the one provided or the configured default

Examples:

```sh
:SCW
:SCW test json
```

This command can be called from normal or visual mode. In normal mode, the
complete buffer will be written to the scratch file. In visual mode, the
highlighted portion will be writed to the scratch file.

### `:SCE [stub] [ext]`

> Write the current buffer to a scratch file and then open that file for editing
> in the current pane

Examples:

```sh
:SCE
:SCE test json
:SCE test rb
```

This command can be called from normal or visual mode. In normal mode, the
complete buffer will be written to the scratch file. In visual mode, the
highlighted portion will be writed to the scratch file.

### `:SCR stub`

> Open the first scratch file in the configured location whose name has the
> string stub in it.

Examples:

```sh
# Open the first file which has the string test in it
:SCR test

# Open the first JSON file
:SCR json
```

### Configuration

You can configure the location that the file is stored at, the time stamp string
to add to the file name etc. Check the top of `autoload/persistent_scratch.vim`
to find the list of available arguments. These are the current set of variables
which can be configured:

```vim
" Where to store the scratch files? Default is inside /tmp and _not_ persistent
let g:persistent_scratch_file_location = "/tmp/scratch"

" Scratch file name has a timestamp built using strftime. You can change the
" format string used in the strftime call by changing this option
let g:persistent_scratch_file_ts_format = "%Y-%m-%d-%H-%M-%S"

" Default file extension for a new Scratch file
let g:persistent_scratch_default_file_ext = "md"
```

**File name construction:** `<scratch_file_location>/<strftime(...)>[-<stub>].<ext>`

## TODO

- [ ] Add documentation in the `doc/` folder
- [ ] Improve examples for read to show usage of regular expressions

## License

Code inside this repo is licensed under the MIT License.

Copyright (c) 2020 [Siddharth Kannan](https://icyflame.github.io)

[1]: https://github.com/icyflame/dotfiles/blob/bf95639f2791127cd58ad5aa55816d2243374d4d/zsh/scratch.zsh#L18
