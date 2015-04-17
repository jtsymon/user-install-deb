#!/bin/bash

fetch() {
    apt-get --print-uris --yes install $@ | \
        grep ^\' | cut -d\' -f2 | \
        tee /dev/stderr \
            2> >(wget --no-clobber --quiet --input-file - >&2) \
             > >(while read url; do basename $url; done)
}

extract() {
    if [[ $# -gt 0 ]]; then
        pkgs="$@"
    else
        pkgs="*.deb"
    fi
    for pkg in $pkgs; do
        echo "Extracting $pkg"
        files=$(ar t $pkg)
        case $files in
            *data.tar.gz*)
                ar p $pkg data.tar.gz | tar xz
                ;;
            *data.tar.xz*)
                ar p $pkg data.tar.xz | tar xJ
                ;;
            *)
                echo "Failed at $pkg" >&2
                exit 1
                ;;
        esac
    done
}

case $1 in
    --clean)
        find . -mindepth 1 -maxdepth 1 -type d -print0 | xargs --interactive -0 rm -rf
        ;;
    --cleandeb)
        rm -if *.deb
        ;;
    *)
        if [[ $# -gt 0 ]]; then
            # Download and install a package
            extract $(fetch $@)
        else
            # Re-extract downloaded packages
            extract
        fi
        ;;
esac
