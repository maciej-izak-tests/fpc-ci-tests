#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

. ./fpcvariables.sh

# special steps for tests for some CPU_TARGETS
case $CPUTARGET in
    avr)
        wget https://github.com/FPK/fp-avrsim/archive/master.zip
        unzip -qq master.zip
        fpc fp-avrsim-master/avrsim.lpr -O4
        echo "timeout -k 2s 60s $main_dir/fp-avrsim-master/avrsim "'$@' >> run-avr
        chmod ugo+x run-avr
        ;;
    i8086)
        fpc freepascal-freepascal/tests/utils/dosbox/dosbox_wrapper.pas
        export DOSBOX=/usr/bin/dosbox
        export SDL_VIDEODRIVER=dummy
        export SDL_AUDIODRIVER=dummy
        export DOSBOX_TIMEOUT=60
        ;;
    m68k)
        echo 'timeout -k 2s 60s qemu-m68k -cpu cfv4e $@' >> run-qemu-m68k
        chmod ugo+x run-qemu-m68k
        ;;
esac

cd $main_dir/freepascal-freepascal/tests/

# TODO? : FPCFPMAKE=ppcross386 , V=1

BASE_PARAMS=("TEST_FPC=$_TEST_FPC")
if ! test -z "$_TEST_SUBARCH"; then BASE_PARAMS+=("\"TEST_SUBARCH=$_TEST_SUBARCH\""); fi
if ! test -z "$_TEST_OPT"; then BASE_PARAMS+=("\"TEST_OPT=$_TEST_OPT\""); fi
if ! test -z "$_EMULATOR"; then BASE_PARAMS+=("\"EMULATOR=$_EMULATOR\""); fi

PARAMS=( "${TEST_MAIN_PARAMS[@]}" "${BASE_PARAMS[@]}" )
#PARAMS=( "allexectbs" "${BASE_PARAMS[@]}"  )
if [ "$HAS_TESTCHUNK" = true ] ;
then
    PARAMS+=( "CHUNKSIZE=50" "-j $J" )
    eval make ${PARAMS[@]}
else
    eval make ${PARAMS[@]}
fi
