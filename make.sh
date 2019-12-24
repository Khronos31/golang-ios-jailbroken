#!/bin/bash

export CC=clang
export CXX=clang++
export AR=llvm-ar
export GOTMPDIR=/usr/tmp

export GOOS=darwin
export GOARCH="${GOARCH-arm64}"
export GOROOT="$(pwd)/go"
export GOROOT_FINAL=/usr/local/libexec/go
export CGO_ENABLED=1

export URL="https://dl.google.com/go/go1.13.5.src.tar.gz"


case "$1" in
	download)
		curl -o go.tar.gz "$URL"
		tar xvf go.tar.gz
		rm go.tar.gz*
		exit 0
	;;
	make)
		echo "Making..."
		cd go/src/
		GOROOT="$(dirname $(pwd))"
		GOROOT_FINAL=$GOROOT_FINAL ./make.bash --no-clean||go install -i cmd/cgo
		GOROOT_FINAL=$GOROOT_FINAL ./make.bash --no-clean
		exit 0
	;;
	clean)
		echo "Cleaning..."
		cd go/src/
		`which bash` ./clean.bash
		exit 0
	;;
	purge)
		echo "Purging..."
		rm -rf go
		exit 0
	;;
	package)
		echo "Packing"
		destdir=deb/usr/local/libexec/go
		mkdir -p $(pwd)/${destdir}
		cp -r go/* ${destdir}/
		dpkg-deb --build deb golang.deb
		echo "TODO: auto clean up unneeded"
		exit 0
	;;
	patch)
		patchdir=patches
		for p in $(find $patchdir -name *.patch); do
			patch -p1 < "$p"
		done
	;;
	*)
		echo "Bad argument - \""$@"\"."
		exit 1
	;;
esac

