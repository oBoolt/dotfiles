<h1 align="center">oBoolt Dotfiles</h1>
In this repository I will upload my configuration files. I really like to
make my configuration to understand how something works. Feel free to use it if you like.

## Installation
```sh
bash <(curl -sS https://raw.githubusercontent.com/oBoolt/dotfiles/refs/heads/main/install.sh)
```

## Components
 - quickshell
 - hyprland
 - starship
 - alacritty
 - tmux
 - zsh

## Usage
In the install script you be asked if you want to setup your dotfiles, this will create the links
and backup your old config in the backup folder, the script will also set your current theme to be `gruvbox`.
Whatever if you want to setup later use the command:
```
$ dotfiles config
```
To set a different theme use:
```
$ dotfiles theme <theme>
```
and you can list all the available themes using:
```
$ dotfiles theme --list
```
