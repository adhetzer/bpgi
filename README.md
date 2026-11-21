# `bpgi` Adds Boilerplate Templates to Your Working Directory's `.gitignore` File

`bpgi` is a `bash` script that appends boilerplate `.gitignore` templates to the current directory's `.gitignore` file. It is designed to quickly add files and/or directories you do not want to perform version control on to a `.gitignore` file, especially when new services or technologies are added to your stack.

`bpgi` uses GitHub's collection of [gitignore](https://github.com/github/gitignore) templates as a starting point for the templates one can append to their working directory's `.gitignore`. Each `.gitignore` template's file takes the name `<ServiceName>.gitignore`.

All `.gitignore` templates used by `bpgi` are expected to be stored in `$HOME/.local/share/bpgi/gitignore`. Users may add additional `.gitignore` templates for services not included to this directory or edit existing `.gitignore` templates to better suit one's needs.

## AI Disclaimer
This app was written by hand. But ChatGPT was used to fix bugs in it.
