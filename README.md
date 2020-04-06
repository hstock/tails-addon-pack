Additional package downloader
=============================

Helps downloading packages missing from i.E. Tails distribution for placement
on a USB stick for transfer to an offline system.

You specify a list of wanted packages and the script will give you a list
of packages missing in the distribution, including their dependencies.

Usage
-----

Use a local apt config:

    export APT_CONFIG="apt/etc/apt/apt.conf"
    apt-get update

You can now use apt-commands for querying the package database and downloading
packages.

**WARNING:** Do not install or remove any packages - this will mess up your system (probably
only if you run as root)

You need a file listing your wanted packages one package per line and a file listing
the packages present in the distribution.

Example run:

    ./generate-downloadlist.sh wanted-packages <(cut -f 1 < tails-amd64-4.4.1.packages )

or in order to download the `.deb`s:

    ./generate-downloadlist.sh wanted-packages <(cut -f 1 < tails-amd64-4.4.1.packages ) | xargs -n1 apt-get download

Caveats
-------

Currently the script will show pure virtual packages. Downloading these with `apt-get download` will generate an error.
Also dependencies might be missing due to this - if the virtual dependency is not satisfied on the target system.

The above download command will just skip these packages.

