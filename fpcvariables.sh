#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

case $CPUTARGET in
    i386)
        _OS_TARGET=linux
        _CPU_TARGET=i386
        _SUBARCH=
        _PPCROSS=ppcross386
        _BINUTILSPREFIX=
        _OPT=-O3
        _CROSSOPT=
        _TEST_OPT=
        _TEST_FPC="$_PPCROSS"
        _TEST_SUBARCH=
        _EMULATOR=
        HAS_CROSS=true
        HAS_TESTCHUNK=true
        TESTS_DIR=i386-linux
        ;;
    x86_64)
        _OS_TARGET=
        _CPU_TARGET=x86_64
        _SUBARCH=
        _PPCROSS=
        _BINUTILSPREFIX=
        _OPT=
        _CROSSOPT=
        _TEST_OPT=
        _TEST_FPC=ppcx64
        _TEST_SUBARCH=
        _EMULATOR=
        HAS_CROSS=false
        HAS_TESTCHUNK=true
        TESTS_DIR=x86_64-linux
        ;;
    avr)
        _OS_TARGET=embedded
        _CPU_TARGET=avr
        _SUBARCH=avr5
        _PPCROSS=ppcrossavr
        _BINUTILSPREFIX=avr-
        _OPT=-O3
        _CROSSOPT=
        _TEST_OPT="-O4 -al -XPavr- -Wpavrsim"
        _TEST_FPC="$_PPCROSS"
        _TEST_SUBARCH="$_SUBARCH"
        _EMULATOR=$main_dir/run-avr
        HAS_CROSS=true
        HAS_TESTCHUNK=true
        TESTS_DIR=avr-embedded
        ;;
    i8086)
        _OS_TARGET=msdos
        _CPU_TARGET=i8086
        _SUBARCH=
        _PPCROSS=ppcross8086
        _BINUTILSPREFIX=
        _OPT="-CX -XX -XP -XXs"
        _CROSSOPT="-WmMedium"
        _TEST_OPT="-CX -XX -XP -XXs -WmMedium"
        _TEST_FPC="$_PPCROSS"
        _TEST_SUBARCH=
        _EMULATOR=$main_dir/$fpcsrc/tests/utils/dosbox/dosbox_wrapper
        HAS_CROSS=true
        HAS_TESTCHUNK=false
        TESTS_DIR=msdos
        ;;
    m68k)
        _OS_TARGET=linux
        _CPU_TARGET=m68k
        _SUBARCH=
        _PPCROSS=ppcross68k
        _BINUTILSPREFIX=m68k-elf-
        _OPT=
        _CROSSOPT="-O- -Cpisac"
        _TEST_OPT="-O- -Cpisac -XPm68k-elf-"
        _TEST_FPC="$_PPCROSS"
        _TEST_SUBARCH=
        _EMULATOR=$main_dir/run-qemu-m68k
        HAS_CROSS=true
        HAS_TESTCHUNK=true
        TESTS_DIR=m68k-linux
        ;;
    *)
        exit 1
esac