# debian-utils

Various linux/debian/ubuntu confs & scripts

## Installed

### Console & prompt

* `sudo apt install konsole vim jq tree smplayer vlc build-essential clang zlib1g-dev libffi-dev libssl-dev libbz2-dev tk-dev libreadline-dev libsqlite3-dev liblzma-dev curl git git-gui git-absorb gitk gnome-tweaks chrome-gnome-shell htop zsh fonts-firacode fzf ffmpeg libgtk-3-dev puddletag`
* ssh key
* snazzy colorscheme for konsole (+ all black background) : https://github.com/miedzinski/konsole-snazzy in /usr/share/konsole
  then activate it in profile
* install fonts-firacode (and ttf-ancient-fonts-symbola if necessary on old OS), then activate it in konsole profile
* define konsole profile to be "default" (using 'which zsh')
* rustup
* vscode
* docker + symlink /var/lib/docker -> /home/docker for space (same for PG?), then 'sudo service docker restart'
* rabbitmq: docker run -d --restart unless-stopped --hostname docker-rabbitmq --name pierretienne-rabbitmq -e RABBITMQ_DEFAULT_USER=XXXX -e RABBITMQ_DEFAULT_PASS=XXXX -p 15672:15672 -p 15671:15672 -p 5672:5672 -p 5671:5671 rabbitmq:management-alpine
* redis: docker run -d --restart unless-stopped --hostname docker-redis --name pierretienne-redis -p 6379:6379 redis:alpine
* postgresql: docker run -d --restart unless-stopped --hostname docker-postgres --name pierretienne-postgres -e POSTGRES_USER=XXXX -e POSTGRES_PASSWORD=XXXX -e PGDATA=/var/lib/postgresql/data/pgdata -v /home/postgres:/var/lib/postgresql/data -p 5432:5432 postgres:13-alpine
* git-gui options : "none" as spellchecker dictionnary
* Remove autostart ssh-agent to manage keys
* Add autostart sound (cp control_sound.desktop ~/.local/share/applications/control_sound.desktop, then tweak gnome)
* Remove bluetooth autostart (AutoEnable=false in /etc/bluetooth/main.conf)
* add symlinks to all ./home/ files
* pyenv, pyenv-virtualenv, pyenv install 3.8.9, pyenv virtualenv 3.8.9 ds4
* gron for `jsongrep` : https://github.com/tomnomnom/gron#installation
* https://github.com/pkolaczk/fclones to spot file cloned (or use 'czkawka_gui')
* https://github.com/wfxr/csview to read csv files
* add git and docker shortcuts/integrations for zsh?

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
* Pixel Saver (crashes on Ubuntu 21.10, "No Title Bar When Maximized" not available either but possible on 22.04)
* Removable Drive Menu
* Workspace Indicator
* System monitor
* Custom Hot Corners

## By computer type

### M3800

Provide iwlwifi-7260-17.ucode (inside firmware.zip inside firmware-iwlwifi deb package) at OS install.

Install gnome-tweak-tool, then activate "Area" click to get right-click.

`sudo apt install firmware-linux nvidia-smi` (nvidia-detect)
