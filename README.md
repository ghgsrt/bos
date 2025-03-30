# Bos

This project aims to facilitate (mostly) generic operating system setup and usage to make my life as easy as possible. It's meant solely for me, and largely as a learning experience, but I intend to make most of its functionality generic (probably excessively so) so perhaps someone else may find it of use. Certainly, the guix portions contains a few snippets that weren't very straight forward to figure out via documentation alone, and thus may be useful in their own right for any weary travelers.

While I will make an attempt to document the current state of the project below, I will mostly be using this space for brainstorming, so don't expect everything I mention to be functional yet.

At the moment and for the foreseeable future, only Guix is properly supported. This won't be necessary once I've set up the toml configuration, but for now, after booting into your os, cloning, and cd'ing into this repo, run:
```bash
./init.sh -O [os name] -D [dotfiles name] -C [config name] -S [system name]
```
Where `O` should be "guix", `D` should be the name of the dotfiles config directory relative to the bos/dotfiles directory, `C` should be the name of the guix config directory relative to the bos/configs directory, and `S` should be the name of the system file (without ".scm") as located relative to `guix_config_dir/system/` (with the system directory being configurable through the toml config).
For home, add the following flags to the above command:
```bash
./init.sh ... -T [guix|nix] -H [home name]
```
Where `T` denotes which provider to use for a home manager (with the toml config this becomes irrelevant as you'll be able to define both simultaneously) and `H` should be the name of the home file (without ".scm") in the same way as system above (with home/ being the hardcoded directory it will look in).

As an example, here's what the command looks like for my current config:
```bash
./init.sh -O guix -D dotfiles -C guix -S zenbook -T guix -H has-x-full
```

This will symlink all of your dotfiles, create a /etc/bos/profile containing environment variables denoting the current bos state, create a /etc/bos/bashrc which for now needs to be manually sourced if you aren't using bash that exposes the CLI described below, and attempts a system and/or home reconfigure (which can be disabled by passing `-nr`).

##### Configs
The intention is for the user to be able to provide either a guix config, a nix config, or a (TBD) custom configuration file to automate initialization after first booting into a fresh install. In the case of Guix and Nix, you will be able to use the configuration file to optionally map symbols to particular system or home configurations along arbitrary paths and across multiple configs, allowing you to expose the contents of one or more configs with a convenient reconfiguration syntax. The end goal is to support (for home) managing Nix and Guix configs simultaneously via a unified CLI.
```bash
[s|h]rec config-file-name|symbol
```
When calling the above, bos will first look to see if you've mapped the provided symbol in the active toml configuration (iff a toml config was actually specified) for a .scm or .nix file of that name within the pre-specified system/home directory(ies). If it isn't found, it will then check for a main.[scm|nix] in the aforementioned directories while passing in the config name/symbol as an environment variable TARGET.

##### Dotfiles
A major goal of this project is enabling convenient linking of (mostly) arbitrary dotfiles, as well as ease of switching between different sets of dotfiles to facilitate experimentation without the headache. For now, you may only specify a single dotfiles directory to link, but eventually multiple should be supported because why not.
The directory structure should be as follows:
- root/ => contains files to be linked relative to /
- home/ => contains files to be linked relative to $HOME
You may also have specific directories for per-"X" file linking, where these directories should contain subdirectories corresponding to valid values of "X" which contain root/ and/or home/ (e.g., dotfiles/X/X-value/home/...):
    - user/ => Per-user file linking (e.g., dotfiles/user/ghgsrt/home/...)
    - os/ => Per-os file linking (e.g., dotfiles/os/Arch/home/...)
    - system/ => (Guix/Nix only) Per-system file linking (e.g., dotfiles/system/zenbook/home/...)
Switching anything that works on a per-"X" basis will unlink the prior X-specific files and attempt to relink the new X-specific files if the relevant directory exists.
Note that not all of the per-"X" work yet.

##### Guix Extension
Calling srec or hrec when using guix will actually load the bos/guix directory, take your operating-system or home-environment object, and extend it with some things to better facilitate this project (e.g., injecting sourcing for /etc/bos/profile into your bash_profile). Although, at the moment, I also have it adding some additional baseline packages that any system should want. It also provides a utility for taking any arbitrary operating-system object and converting it into a WSL2 compatible image (with more image types to come) and empty (blank) system and home definitions that can be used by passing in `-e` (an example of why this may be useful is reconfiguring into an empty home, deleting all generation, then gc'ing for an easy way to trigger a full rebuild (let me know if there's a simpler mechanism for this)).

## References

- [Guix Config: SSS](https://codeberg.org/jjba23/sss)
- [Guix Config: System Crafters guixos-sway](https://codeberg.org/loraz/guixos-sway)

- [GnuPG keyring](https://adfinis.com/en/blog/gnupg-and-smartcards/)
- [GnuPG for SSH](https://wiki.archlinux.org/title/GnuPG#SSH_agent)

- [BTRFS example](https://github.com/podiki/dot.me/blob/master/guix/.config/guix/config.scm)
- [BTRFS w/ full disk LUKS](https://github.com/yveszoundi/guix-config?tab=readme-ov-file)
- [LUKS example](https://gitlab.com/martin-baulig/config-and-setup/guix-packages/-/blob/work-lothlorien/system/lothlorien/config.scm?ref_type=heads)
- [LUKS encrypted directory-in-a-file](https://www.lpenz.org/articles/luksfile/)

- [Guix in LXC](https://www.thedroneely.com/posts/guix-in-a-linux-container/)
