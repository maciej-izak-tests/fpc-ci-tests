#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

case $CPUTARGET in
    m68k)
        TARGET=m68k-elf
        ;;
    avr)
        TARGET=avr
        ;;
    i386)
        TARGET=i386-linux
        ;;
    i8086)
        # nonstandard binutils for msdos
        mkdir -p $main_dir/binutils/bin
        wget https://github.com/newpascal/fpcupdeluxe/releases/download/linuxx64crossbins_v1.0/CrossBinsMSDosi8086.zip
        unzip -qq CrossBinsMSDosi8086.zip -d binutils/bin
        cd $main_dir/binutils/bin
        cp nasm msdos-nasm
        chmod -R 777 $main_dir/binutils/bin 
        exit 0
        ;;
    *)
        exit 0
esac

wget ftp://ftp.gnu.org/gnu/binutils/binutils-2.29.1.tar.bz2
tar xjf binutils-2.29.1.tar.bz2
cd binutils-2.29.1
./configure --target=$TARGET --prefix=$main_dir/binutils
make > /dev/null 
make install > /dev/null