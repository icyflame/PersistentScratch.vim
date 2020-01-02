# PersistentScratch.vim

> Scratch files in persistent storage

## Why?

Often, I have wanted to store text in a file without thinking much about the
file name or where it is stored. The text in this file is essentially scratch
text but I want to have it stored in persistent storage, on the off chance that
I need it later. I started with a few Bash functions which created these files
and named them appropriately.

This worked fine as long as I didn't have to open the file back up or create the
file from inside vim itself. Thus, this Vim plugin:

- Call `:SCW` to write the current buffer to a persistent scratch file in a
  pre-defined location.
- Call `:SCE pod-logs json` to store some JSON in a file - Maybe you want to run
  some `jq` commands on this or you want to fetch it later to share with someone
  else.

### Configuration

You can configure the location that the file is stored at, the time stamp string
to add to the file name etc. Check the top of `autoload/persistent_scratch.vim`
to find the list of available arguments.

## License

Code inside this repo is licensed under the MIT License.

Copyright (c) 2020 [Siddharth Kannan](https://icyflame.github.io)
