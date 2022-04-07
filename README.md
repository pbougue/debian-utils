# debian-utils

Various linux/debian/ubuntu confs & scripts

## Installed

### Console & prompt

* `sudo apt install konsole smplayer vlc clang curl git git-gui gitk gnome-tweaks chrome-gnome-shell htop zsh fonts-firacode fzf`
* ssh key
* snazzy colorscheme for konsole (+ all black background) : https://github.com/miedzinski/konsole-snazzy in /usr/share/konsole
  then activate it in profile
* install fonts-firacode (and ttf-ancient-fonts-symbola if necessary on old OS), then activate it in konsole profile
* rustup
* vscode
* add git and docker shortcuts/integrations for zsh?
* git-gui options : "none" as spellchecker dictionnary
* Remove autostart ssh-agent to manage keys
* define konsole profile to be "default" (using 'which zsh')
* pyenv, pyenv virtualenvwrapper, pyenv install 3.8.6, pyenv global 3.8.6
* gron for `jsongrep` : https://github.com/tomnomnom/gron#installation
* https://github.com/pkolaczk/fclones to spot file cloned
* https://github.com/wfxr/csview to read csv files

## gnome extensions

https://doc.ubuntu-fr.org/extensions-gnome#installation_manuelle_des_extensions

```bash
sudo apt install gnome-shell-extension-system-monitor
```

* Auto Move Windows
* AlternateTab
* Multi Monitors Add-On
* Native Window Placement
* ShellTile
* Pixel Saver (crashes on Ubuntu 21.10, "No Title Bar" not available either)
* Removable Drive Menu
* Workspace Indicator
* System monitor
* Custom Hot Corners

## By computer type

### M3800

Provide iwlwifi-7260-17.ucode (inside firmware.zip inside firmware-iwlwifi deb package) at OS install.

Install gnome-tweak-tool, then activate "Area" click to get right-click.

`sudo apt install firmware-linux nvidia-smi` (nvidia-detect)
