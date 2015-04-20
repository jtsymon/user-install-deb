# User Install Deb

A script for installing deb packages without root privileges.

Supports automatically fetching and installing packages and their dependencies.

Only supports fetching packages from the deb repositories configured on the system.

## Setup

1. Clone this repository to somewhere in your home folder: `git clone https://github.com/jtsymon/user-install-deb $PKGHOME`
2. Set up your PATH: `echo 'export PATH="$PKGHOME/usr/bin:$PATH"' >> ~/.bashrc`
3. Set up your LD_LIBRARY_PATH (this is for library dependencies which may be installed): `echo 'export LD_LIBRARY_PATH="$PKGHOME/usr/lib/:$PKGHOME/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"' >> ~/.bashrc`

## Usage

* To install a package, just run `./install.sh $package`. The package and any dependencies will be downloaded and extracted into the current working directory.
* To remove installed packages, run `./install.sh --clean`. WARNING: This will delete all folders in the current working directory, so make sure you don't run it in the wrong directory (there is an interactive check to make sure this doesn't happen accidentally).
* To re-extract downloaded packages, run `./install.sh` (without any arguments)
* To remove downloaded packages, run `./install.sh --cleandeb` (or just `rm *.deb`)
