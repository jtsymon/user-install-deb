# User Install Deb

A script for installing deb packages without root privileges.

## Usage

* Run `./install`
* Wait for the automatic bootstrap (only on the first run)
* You will be dropped into a shell with fake root permissions
* From here you can run `apt-get install ...`
* Run `./install env` for environment variable declarations to add to your .profile

## Warning

You WILL get errors when installing packages using this script.

Generally they are simple enough to fix (e.g. missing files with clear error messages).

Feel free to make an issue if you have any problems (or a pull request if you fix anything).

## How it works

The script uses a fakechroot with fakeroot so it can run `apt-get`.

Since we don't actually get root privileges, and we need a writable `dpkg` database, we have to maintain our own separate `dpkg` database.

The separate `dpkg` database needs to know about the installed packages on the main system so it can handle dependencies properly.

`dpkg` doesn't provide any nice way to mark packages as installed, so we have to create empty placeholder packages and install those. This is why the first run takes so long (it is creating and installing empty packages for every package on your main system).
