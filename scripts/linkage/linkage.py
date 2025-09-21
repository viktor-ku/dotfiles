#!/usr/bin/env python

import os
import sys
import stat
import pathlib


YEP = {
    "y",
    "yes",
    "yep",
    "aye",
    "agree",
    "agreed",
    "go",
    "please",
}


def main():
    config_dir, err = find_config_dir()

    if err is not None:
        print(err, file=sys.stderr)
        exit(1)

    cwd = os.getcwd()

    links = []
    for it in sys.argv:
        if is_dir_exists(it):
            src = os.path.join(cwd, it)

            stem = pathlib.Path(it).stem
            dest = os.path.join(config_dir, stem)

            links.append((src, dest))

    force = False
    for it in sys.argv:
        if it == "--force":
            force = True
            break

    if force:
        print("The plan is to create the following symlinks with force:")
    else:
        print("The plan is to create the following symlinks:")

    todo = []
    for src, dest in links:
        status = ""

        if force:
            status = " (force recreate)"
            todo.append((src, dest))
        else:
            if is_symlink_exists(dest):
                status = " (skip, already exists)"
            else:
                todo.append((src, dest))

        print(f"{src} -> {dest}{status}")

    if len(todo) == 0:
        print("Nothing to do")
        exit(0)

    if not user_agreed():
        exit(0)

    for src, dest in todo:
        safe_unlink(dest)
        os.symlink(src, dest)

        print("You are all set")


def user_agreed():
    it = input("What do you think? (y/N): ").strip().lower()

    if it in YEP:
        return True

    return False


def find_config_dir():
    config_dir = os.environ.get("XDG_CONFIG_HOME")

    if config_dir is not None:
        return config_dir, None

    home_dir = os.environ.get("HOME")

    if home_dir is None:
        return None, "Sorry, could not find a home directory"

    config_dir = os.path.join(home_dir, ".config")

    if is_dir_exists(config_dir):
        return config_dir, None

    return None, "Sorry, could not find a config directory"


def is_dir_exists(path):
    return is_exists(path, test=stat.S_ISDIR)


def is_symlink_exists(path):
    return is_exists(path, os_stat=safe_lstat, test=stat.S_ISLNK)


def is_exists(path, os_stat=None, test=None):
    it = None

    if os_stat is None:
        os_stat = safe_stat

    it = os_stat(path)

    if it is None:
        return False

    if test is None:
        return True

    return test(it.st_mode)


def safe_stat(path):
    try:
        return os.stat(path)
    except Exception:
        return None


def safe_lstat(path):
    try:
        return os.lstat(path)
    except Exception:
        return None


def safe_unlink(path):
    try:
        return os.unlink(path)
    except Exception:
        return None


main()
