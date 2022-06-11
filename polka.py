#!/usr/bin/env python

# Polka
# ------
# A very simple handcrafted dotfiles manager, it manages symlinks,
# builds and updates. Note, this was mainly written to suit only
# what I needed and has only been tested locally

import json
import pathlib
import subprocess


# Color and formatting utility funcitons
# The optional info parameter is for adding bold text
def error(text):
    print(f"\u001b[1m\u001b[31m{text}\u001b[0m")


def plain(text, info="", *args, **kwargs):
    print(text.format(f"\u001b[1m{info}\u001b[0m"), *args, **kwargs)


def success(text, info="", *args, **kwargs):
    info = f"\u001b[1m{info}\u001b[0m\u001b[32m"
    print(f"\u001b[32m{text.format(info)}\u001b[0m", *args, **kwargs)


def warn(text, info="", *args, **kwargs):
    info = f"\u001b[1m{info}\u001b[0m\u001b[33m"
    print(f"\u001b[33m{text.format(info)}\u001b[0m", *args, **kwargs)


# Configuration
DOTS_DIR = pathlib.Path(__file__).parent

try:
    with open(DOTS_DIR.joinpath("polkaconf.json"), "r") as file:
        config = json.load(file)
except FileNotFoundError:
    error("Could not find your polkaconf.json file!")
    quit(1)

TARGET_DIR = pathlib.Path(config["target_dir"]).expanduser()

# DOTS_DIR - Root of the repository (eg: ~/Dotfiles)
# TARGET_DIR - Where to link config files to (eg: ~/.config)


def execute_command(command):
    error_code = subprocess.Popen(
        command,
        cwd=DOTS_DIR,
        env={"DOTFILES_DIR": DOTS_DIR},
    ).wait()

    if error_code == 0:
        success("Finished command execution successfully!")
    else:
        error("An error occured whilst running the command!")
        quit(error_code)


# Actions
def run_full():
    update_self()
    run_builds()
    link_dots()


def update_self():
    plain("\n{}", "Syncing modules...")
    execute_command(config["sync_command"])


def run_builds():
    plain("\n{}", "Running build script...")
    execute_command(DOTS_DIR.joinpath(config["build_script"]))


def link_dots():
    plain("\n{}", "Linking dotfiles...")

    for dotfile in config["tracking_links"]:
        source = DOTS_DIR.joinpath(dotfile)
        target = TARGET_DIR.joinpath(dotfile)

        if target.exists():
            if target.is_symlink() and target.readlink().parent == DOTS_DIR:
                success("Target {} is already linked correctly", dotfile)
            else:
                warn("Target {} exists but is not linked", dotfile)
        else:
            target.symlink_to(source)
            success("Target {} was linked successfully", dotfile)


# User prompt
print("""\u001b[30m\u001b[1m ____       _ _
|  _ \\ ___ | | | ____ _
| |_) / _ \\| | |/ / _` |
|  __| (_) | |   | (_| |
|_|   \\___/|_|_|\\_\\__,_|\u001b[0m
""")


actions = [
    [run_full, "Full install"],
    [update_self, "Update self"],
    [run_builds, "Run build script"],
    [link_dots, "Link dotfiles"]
]

for idx, info in enumerate(actions):
    plain("{} " + info[1], f"{idx}.")

print()

action_list = []

while True:
    plain("{}", ">> ", end="")
    action_list = input()

    try:
        # Convert numbers to a list
        action_list = list(map(int, list(action_list)))

        # Checks how many valid numbers are entered
        assert len([action for action in action_list if action > len(actions) - 1]) == 0

        break

    except (ValueError, AssertionError):
        error("Incorrect values entered!")

# Don't run other actions if doing a full install
if 0 in action_list:
    run_full()
else:
    for action in action_list:
        actions[action][0]()

