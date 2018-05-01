#!/bin/bash

version="0.7.0"

target_dir="/Users/dev/Documents/__bisq/_releases/$version"
src_dir="/Users/dev/idea/exchange"

rm -r $target_dir

mkdir -p $target_dir

# new signing key
#cp "$target_dir/../7D20BB32.asc" "$target_dir/"

# sig key mkarrer
cp "$target_dir/../F379A1C6.asc" "$target_dir/"
# sig key cbeams
cp "$target_dir/../5BC5ED73.asc" "$target_dir/"
# sig key Christoph Atteneder
cp "$target_dir/../29CDFD3B.asc" "$target_dir/"
# signing key
cp "$target_dir/../signingkey.asc" "$target_dir/"

mac="Bisq-$version.dmg"
cp "$src_dir/deploy/$mac" "$target_dir/"

deb32="Bisq-32bit-$version.deb"
cp "/Users/dev/vm_shared_ubuntu14_32bit/$deb32" "$target_dir/"

deb64="Bisq-64bit-$version.deb"
cp "/Users/dev/vm_shared_ubuntu/$deb64" "$target_dir/"

#rpm32="Bisq-32bit-$version.rpm"
#cp "/Users/dev/vm_shared_ubuntu14_32bit/$rpm32" "$target_dir/"

#rpm64="Bisq-64bit-$version.rpm"
#cp "/Users/dev/vm_shared_ubuntu/$rpm64" "$target_dir/"


exe="Bisq-$version.exe"
win32="Bisq-32bit-$version.exe"
cp "/Users/dev/vm_shared_windows_32bit/bundles/$exe" "$target_dir/$win32"
win64="Bisq-64bit-$version.exe"
cp "/Users/dev/vm_shared_windows/bundles/$exe" "$target_dir/$win64"
#cp "/Users/dev/vm_shared_windows/bundles/$exe" "/Users/dev/vm_shared_win10/$win64"

cd "$target_dir"


gpg --digest-algo SHA256 --local-user manfred@bitsquare.io --output $mac.asc --detach-sig --armor $mac
gpg --digest-algo SHA256 --local-user manfred@bitsquare.io --output $deb64.asc --detach-sig --armor $deb64
gpg --digest-algo SHA256 --local-user manfred@bitsquare.io --output $deb32.asc --detach-sig --armor $deb32
gpg --digest-algo SHA256 --local-user manfred@bitsquare.io --output $win64.asc --detach-sig --armor $win64
gpg --digest-algo SHA256 --local-user manfred@bitsquare.io --output $win32.asc --detach-sig --armor $win32

gpg --digest-algo SHA256 --verify $mac{.asc*,}
gpg --digest-algo SHA256 --verify $deb64{.asc*,}
gpg --digest-algo SHA256 --verify $deb32{.asc*,}
gpg --digest-algo SHA256 --verify $win64{.asc*,}
gpg --digest-algo SHA256 --verify $win32{.asc*,}

cp -r $target_dir /Users/dev/vm_shared_windows_32bit/

open "$target_dir"
