#! /bin/bash

# A script for installing all the required stuff for a new (debian) PC
#
# re-running this on a working PC shouldn't break anything but doesn't
# need to quickly skip things

mkdir -p ~/bin ~/opt ~/repos

echo "> apt-get updating"
sudo apt-get -qq update 

echo "> apt-get installing"
sudo apt-get -qq install -y  \
  apt-transport-https \
  bzip2 \
  cheese \
  curl \
  flatpak \
  geeqie \
  git \
  gnome-software-plugin-flatpak \
  gnome-tweak-tool \
  gnupg \
  guake \
  jq \
  libwww-perl \
  lsb-release \
  net-tools \
  openarena \
  pylint \
  python3 \
  python3-pip \
  python3-venv \
  rclone \
  shellcheck \
  sshfs \
  tmux \
  vim \
  virt-manager \
  vlc \
  wget \
  yq \
  yamllint

echo "> Setting up sudo"
tmpfile=/tmp/bin-init-sudo
echo "%sudoers ALL=(ALL) NOPASSWD:/usr/bin/apt, /usr/bin/dmesg, /usr/bin/netstat, /usr/bin/tcpdump, /usr/sbin/iptables, /usr/bin/mount, /usr/sbin/fdisk, /usr/bin/dpkg, /usr/bin/journalctl, /usr/bin/systemctl"  > $tmpfile
echo "%sudoers ALL=(ALL) ALL" >> $tmpfile
if sudo visudo -c $tmpfile ; then
  echo "> Installing new /etc/sudoders.d/avi file"
  sudo mv $tmpfile /etc/sudoers.d/avi
  sudo chown 0:0 /etc/sudoers.d/avi
else
  echo "> Verification of sudoers file failed!"
  exit
fi


if [ -f /usr/bin/firefox-trunk ]; then
  echo "> Nightly already installed"
else
  echo "> Installing nightly"
  sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa
  sudo apt-get update
  sudo apt-get install firefox-trunk -y
  sudo ln -s /usr/bin/firefox-trunk ~/bin/nightly
  nightly &
fi

if [ -f ~/.ssh/id_rsa.pub ]; then
  echo "> ssh key already generated"
else
  echo "> ssh-keygenning"
  ssh-keygen -f ~/.ssh/id_rsa
fi

echo
cat ~/.ssh/id_rsa.pub
echo

read -p "Press a key to continue"

if [ -f ~/bin/chezmoi ]; then
  echo "> chezmoi already installed"
else
  echo "> installing chezmoi"
  sh -c "$(curl -fsLS get.chezmoi.io)"
  ~/bin/chezmoi git remote add origin git@github.com:BigRedS
  ~/bin/chezmoi git pull origin main
  ~/bin/chezmoi apply
fi

source ~/.bashrc

echo "> Flatpak installing"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --system com.authy.Authy \
                                 com.dropbox.Client \
                                 net.cozic.joplin_desktop \
                                 dev.k8slens.OpenLens \
                                 org.signal.Signal \
                                 com.slack.Slack \
                                 com.todoist.Todoist \
                                 com.visualstudio.code \
                                 us.zoom.Zoom

echo "> Pip installing"
pip install boto3 requests json re time jsonpickle 

echo "adding deb repos"

if [ -f /etc/apt/sources.list.d/hashicorp.list ]; then
  echo "> Terraform already setup"
else
  echo "> Adding hashicorp repo"
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor |sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt-get update
fi

if [ -f /etc/apt/sources.list.d/docker.list ]; then
  echo "> Docker already setup"
else
  echo "> Adding docker repo"
  for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get -qq remove $pkg; done 
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # Add the repository to Apt sources:
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get -qq update

  sudo groupadd docker ; sudo useradd $USER docker ; sudo newgrp docker
fi

echo "> apt-get installing from new repos"
sudo apt-get -qq install terraform docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "> editing /proc"
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p

echo "> setting root's editor"
sudo grep -q VISUAL=vim /root/.bashrc || echo "export VISUAL=vim" | sudo tee -a /root/.bashrc
