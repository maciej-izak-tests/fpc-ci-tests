#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

case $CPUTARGET in
    i386)
        export _OS_TARGET=linux
        export _CPU_TARGET=i386
        export _SUBARCH=
        export _PPCROSS=ppcross386
        export _BINUTILSPREFIX=
        export _OPT=-O3
        export _CROSSOPT=
        export _TEST_OPT=
        export _TEST_FPC="$_PPCROSS"
        export _TEST_SUBARCH=
        export _EMULATOR=
        export HAS_CROSS=true
        export HAS_TESTCHUNK=true
        export TESTS_DIR=i386-linux
        ;;
    x86_64)
        export _OS_TARGET=
        export _CPU_TARGET=x86_64
        export _SUBARCH=
        export _PPCROSS=
        export _BINUTILSPREFIX=
        export _OPT=
        export _CROSSOPT=
        export _TEST_OPT=
        export _TEST_FPC=ppcx64
        export _TEST_SUBARCH=
        export _EMULATOR=
        export HAS_CROSS=false
        export HAS_TESTCHUNK=true
        export TESTS_DIR=x86_64-linux
        ;;
    avr)
        export _OS_TARGET=embedded
        export _CPU_TARGET=avr
        export _SUBARCH=avr5
        export _PPCROSS=ppcrossavr
        export _BINUTILSPREFIX=avr-
        export _OPT=-O3
        export _CROSSOPT=
        export _TEST_OPT="-O4 -al -XPavr- -Wpavrsim"
        export _TEST_FPC="$_PPCROSS"
        export _TEST_SUBARCH="$_SUBARCH"
        export _EMULATOR=$main_dir/run-avr
        export HAS_CROSS=true
        export HAS_TESTCHUNK=true
        export TESTS_DIR=avr-embedded
        ;;
    i8086)
        export _OS_TARGET=msdos
        export _CPU_TARGET=i8086
        export _SUBARCH=
        export _PPCROSS=ppcross8086
        export _BINUTILSPREFIX=
        export _OPT="-CX -XX -XP -XXs"
        export _CROSSOPT="-CX -XX -XP -WmMedium"
        export _TEST_OPT="-CX -XX -XP -XXs -WmMedium"
        export _TEST_FPC="$_PPCROSS"
        export _TEST_SUBARCH=
        export _EMULATOR=$main_dir/$fpcsrc/tests/utils/dosbox/dosbox_wrapper
        export HAS_CROSS=true
        export HAS_TESTCHUNK=false
        export TESTS_DIR=msdos
        ;;
    m68k)
        export _OS_TARGET=linux
        export _CPU_TARGET=m68k
        export _SUBARCH=
        export _PPCROSS=ppcross68k
        export _BINUTILSPREFIX=m68k-elf-
        export _OPT=
        export _CROSSOPT="-O- -Cpisac"
        export _TEST_OPT="-O- -Cpisac -XPm68k-elf-"
        export _TEST_FPC="$_PPCROSS"
        export _TEST_SUBARCH=
        export _EMULATOR=$main_dir/run-qemu-m68k
        export HAS_CROSS=true
        export HAS_TESTCHUNK=true
        export TESTS_DIR=m68k-linux
        ;;
    *)
        exit 1
esac