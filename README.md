# User Install Deb

A script for installing deb packages without root privileges.

I use this to install useful/up-to-date software on university lab machines without having to compile everything from scratch.

## Usage

* Run `./user-install-deb`
* Wait for the automatic bootstrap (only on the first run)
* You will be dropped into a shell in which you can modify any file on the root filesystem
* To install packages, first run fakeroot, then you can use `apt install <package>
* To use your installed packages, you need to be running inside the shell

## How it works

`unionfs` is used to create a filesystem which is a union of the real root filesystem, and a writable folder which we own.
We can read files from the real root filesystem, but when we modify them they are saved to the writable folder.

`fakechroot` is used to treat this union filesystem as the root filesystem.
This also allows us to pass-through certain files/folders, which is used for folders which should be excluded from the unionfs (`$HOME`, `/tmp`, `/dev`, ...)

`fakeroot` is included to appear as the root user for running programs that check the user-id (e.g. `dpkg` when installing packages).
