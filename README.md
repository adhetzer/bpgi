# `bpgi` - Quickly add boilerplate gitgnore templates to your project

`bpgi` is a `bash` script that appends boilerplate `.gitignore` templates to the current directory's `.gitignore` file. `bpgi` is especially useful when we add a new service or technology to an existing project's stack that has it's own unique set of files and/or directories that we do not want to track.

All `.gitignore` templates used by `bpgi` are expected to be stored in `$HOME/.local/share/bpgi/gitignore`. `bpgi` expects a gitignore template's file name to take the following form: `<ServiceName>.gitignore`.

Users may create additional `.gitignore` templates for services not included to this directory or edit existing `.gitignore` templates to better suit one's needs. My personal implementation of `bpgi` uses GitHub's [collection of gitignore templates](https://github.com/github/gitignore) as the starting point for my `$HOME/.local/share/bpgi/gitignore` directory. Additional `.gitignore` templates may be generated at Toptal's [gitignore.io](https://www.toptal.com/developers/gitignore/).

## Writing Your Own `.gitignore` Templates

Please see the [gitignore](https://git-scm.com/docs/gitignore#_pattern_format) documentation for more information on how patterns in `gitignore` files specify "intentionally untracked files that Git should ignore."

## Security Disclaimer

A `.gitignore` file is not sufficient on its own for credential or app security. Please ensure that all information that you do not wish to share is properly masked, encrypted, and/or anonymized.

If you have committed sensitive information to a repository, like API keys, or passwords, please rotate those credentials as soon as possible.

### `.gitignore` isn't enough on its own to stop tracking a file in Git

If we have a file that is currently tracked by Git that we no longer want Git to track, we must tell Git to stop tracking that file AND add the file name, or a pattern that matches it, to the project's `.gitignore` file.

To tell Git to stop tracking a given file (`<pathspec>`), we run the following command:

```bash
git rm --cached <pathspec> [<pathspec2> <pathspec3>...]
```

The `--cached` option unstages and removes the given files from Git's index. The files passed to this command will remain in the directory, but will no longer be tracked by Git<sup>[1](https://git-scm.com/docs/git-rm#Documentation/git-rm.txt---cached)</sup>.

To stop the `<pathspec>` file from being tracked in the future, we can manually add it to the `.gitignore` file. To do this, we must first navigating to the directory the `.gitignore` file is saved in and then run:

```bash
echo "<pathspec>" >> .gitignore
```

Once the `<pathspec>` file is added to `.gitignore`, it will no longer be tracked by Git.

### Removing a file from Git's version control does not remove commits containing sensitive information from Git's history

If secrets or credentials have been committed to a directory already, **the above process will *not* remove sensitive information from a repo's object database**.

This means if a file containing sensitive information was ever tracked by Git, that information will ALWAYS be available in Git, even after the file containing it is no longer tracked. If you ever tracked a file with sensitive information, please rotate compromised credentials as soon as possible.

## AI Disclaimer

This app was written by hand, but ChatGPT was used to find and fix some bugs.
