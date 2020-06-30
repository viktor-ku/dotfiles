# dotfiles

> Platform specific .dotfiles sync: yes you can have different files synced based on your current OS

## Fork Me

You can fork this repo and:

1. replace what's inside of the `files/` directory
2. replace the mappings in the `files.json`

It's super intuitive, you just run `node link.js` and all your files will become linked.

### Skip option

If you don't want to replace some of the files with link, then add `--skip` parameter like that:
`node link.js --skip`. It will link whatever is not linked yet and leave everything else alone :)

### Other platforms

Check out Nodejs `os.platform()` function and what it returns. You can create mappings in the `files.json`
and corresponding directories inside of the `files/` to match them. Then, it will sync whatever
files are under your OS directory.

### Common files

Sometimes you might have files that you just want to have everywhere you go. In these cases you can
place them directly in the `files/` directory, without any additional folders, and use `common` section
in the `files.json` mappings file. These files will be added to your specific OS mappings.

**Note**, that using common mapping would only make sense if you are using only Unix-like systems, or,
at least, systems that have the same way of describing paths. Otherwise you wouldn't be able to define
the `target`.
