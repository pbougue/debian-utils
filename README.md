# debian-utils

Various linux/debian/ubuntu confs & scripts

## Installed

### Console & prompt

* `sudo apt install konsole smplayer vlc libssl-dev clang curl git git-gui gnome-tweak-tool htop zlib1g-dev`
* ssh key
* snazzy colorscheme for konsole (+ all black background) : https://github.com/miedzinski/konsole-snazzy in /usr/share/konsole
  then activate it in profile
* install fonts-firacode (and ttf-ancient-fonts-symbola if necessary on old OS), then activate it in konsole profile
* fzf
* rustup
* code
* teams
* add git and docker shortcuts/integrations for zsh?
* define konsole profile to be "default"
* pyenv, pyenv virtualenvwrapper, pyenv install 3.8.6, pyenv global 3.8.6
* gron for `jsongrep` : https://github.com/tomnomnom/gron#installation
* https://github.com/pkolaczk/fclones to spot file cloned
* https://github.com/wfxr/csview to read csv files

## gnome extensions

- Auto Move Windows
- AlternateTab
- Multi Monitors Add-On
- Native Window Placement
- Pixel Saver
- Removable Drive Menu
- Workspace Indicator

## By computer type

### M3800

Provide iwlwifi-7260-17.ucode (inside firmware.zip inside firmware-iwlwifi deb package) at OS install.

Install gnome-tweak-tool, then activate "Area" click to get right-click.

`sudo apt install firmware-linux nvidia-smi` (nvidia-detect)
