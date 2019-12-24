// Copyright 2011 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build cgo,!netgo
// +build darwin dragonfly freebsd

package net

/*
#include <netdb.h>
#cgo darwin,arm LDFLAGS: -miphoneos-version-min=7.0 -arch armv7 --sysroot=/usr/share/SDKs/iPhoneOS.sdk -framework CoreFoundation
#cgo darwin,arm CFLAGS: -miphoneos-version-min=7.0 -arch armv7 --sysroot=/usr/share/SDKs/iPhoneOS.sdk -framework CoreFoundation -Wno-unused-command-line-argument
#cgo darwin,arm64 LDFLAGS: -miphoneos-version-min=7.0 -arch arm64 --sysroot=/usr/share/SDKs/iPhoneOS.sdk -framework CoreFoundation
#cgo darwin,arm64 CFLAGS: -miphoneos-version-min=7.0 -arch arm64 --sysroot=/usr/share/SDKs/iPhoneOS.sdk -framework CoreFoundation -Wno-unused-command-line-argument
*/
import "C"

const cgoAddrInfoFlags = (C.AI_CANONNAME | C.AI_V4MAPPED | C.AI_ALL) & C.AI_MASK
