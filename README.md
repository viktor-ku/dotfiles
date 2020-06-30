# dotfiles

> Platform specific .dotfiles sync

You can fork this repo:

1. replace what's inside of the `files/` directory
2. replace the mappings in the `files.json`

It's super intuitive, you just run `node link.js` and all your files will become linked.

### Skip option

If you don't want to replace some of the files with link, then add `--skip` parameter like that:
`node link.js --skip`. It will link whatever is not linked yet and leave everything else alone :)

### Other platforms

Check out Nodejs `os.platform()` function and what it returns. You can create mappings in the `files.json`
and corresponding directories inside of the `files/` to match them. Then, it will only sync whatever
files are under your OS directory.
