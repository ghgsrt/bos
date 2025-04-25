#!/usr/bin/env bash

# pass no args >>
#   if never called -> ask
#   if called before -> use last args
# Can add a config option to manually define how to handle no args
#   Always ask // Ask if never provided, else use last // Use default if never provided, else use last // Always use default

# dotfiles options:
# - link
# - unlink
# - relink (unlink then link)
# sub-specific items
#   - e.g., distro, system, user, base, all, home, root
#
# So, we have, in order of precedence (last wins):
# - Base files (home/...)
# - OS-specific overrides (os/[os]/home/...)
# - System-specific overrides (system/[system]/home/...)
#   - (Guix/Nix only!)
# - User-specific overrides (user/[user]/home/...)
#
# Terminology:
#  - Base files === dotfiles
#  - sub-specifics === overrides
#
# Handling multiple sets of dotfiles:
#  - The obvious solution is mandating static configuration to minimize weird behavior
#  - In theory, any imperative changes can be tracked in such a way as to essentially create an equivalent static configuration that could be viewed.
#
# Static Configuration:
#   inherits: {[]} a list of paths (relative to bos/dotfiles) to other dotfile configuration tomls or to directories (if directory, will assume use all).
#       - Applied *before* the current configuration (i.e., current config will override)
#   modified-by: {[]} same as inherits but are applied *after* the current configuration (i.e., will override current config)
#   [[dotfiles]]: main configuration table-array where each entry is an actual configuration
#       path: path to either a dotfile directory or a toml config to be overriden
#           - this field is optional if the table name (e.g., [dotfiles.table-name]) matches either a directory or .toml file in the dotfiles directory (toml would get prio)
#       [include]: inclusion table; assumption is anything not explicitly specified will be implicitly excluded. i.e., an empty value for include indicates no files should be used
#           base: {false} pass true|false to affect all
#               - or inline table of: { home = boolean, root = boolean }
#               - or array of paths relative to root of the dotfile directory to denote explicit inclusions, with anything not specified implicitly excluded: [ "root/etc", "home/.config/sway" ]
#           overrides: {false} pass true|false to affect all override types
#               - for each override type, you can supply the same as with base above
#       [exclude]: inverse of include; assumption is anything not explicitly specified will be implicitly included. i.e., an empty value for exclude indicates all files should be used.
#       -- IF both include and exclude are used, specificity gets priority (e.g., excluding from base "home/.config/sway" but including "home/.config/sway/config" will cause config to be used, but nothing else in the sway directory). If the same path is specified in both includes and excludes, then you should think deeply about your life (we'll call it undefined behavior, but realistically I'll just flip a coin when implementing and give one precedence).
#
# Args:
#  [first arg or -p]: path to dotfiles or name supplied in static config table or name corresponding to a dotfiles dir or toml
#  [-f]: force
#       - if a file to be (un)linked also shows in the ~/.cache/bos/symlink_tracking file, then regardless of whether it is currently found to be a symlink it will always be either replaced (link) or removed (unlink)
#  [-F]: dangerous force
#       - if a file to be (un)linked already exists, regardless of the state of that file and regardless of whether it exists in ~/.cache/bos/symlink_tracking (i.e., even if it was created manually rather than due to a previous call of this script), then it will *always* be either replaced (link) or removed (unlink)
#  [-v]: verbose
#  [-t]: target/type
#       - Accepted values:
#           - [b[ase]|o[verrides]|a[ll]]
#               - individual override types may be specified as well
#               - may comma separate for multiple
#           - default: 'all'
#       - 
#  [-i]: inclusions list
#  [-e]: exclusions list
#
# Have it run link on some toml
# Goes through and builds out an expected track variable from inherits, config, modified
# [dotfile identifier]: path
# base = { home = ["included_path", ...], root = ["included_path", ...] }
# ...override types same as base
#
# When going through a given set of dotfiles, it will pull out a path, check to see if that path is already in the expected_track, removes it if so, then adds it to the table for the current set of dotfiles
# Then, after fully parsing the given config, uses the expected_track variable to actually attempt the symlinking, finally comparing with the generated track to ensure there were no issues
#
# Imperative usage will attempt to modify a copy of the original config minimally in such a way that doing a full reset and linking using the altered copy should result in an identical dotfile state as after the imperative usage.
