#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

. ./fpcvariables.sh

# build cross compiler
if [ "$HAS_CROSS" = true ] ;
then
    cd freepascal-freepascal

    BASE_PARAMS=("CROSSINSTALL=1")
    if ! test -z "$_OS_TARGET"; then BASE_PARAMS+=("\"OS_TARGET=$_OS_TARGET\""); fi
    if ! test -z "$_CPU_TARGET"; then BASE_PARAMS+=("\"CPU_TARGET=$_CPU_TARGET\""); fi
    if ! test -z "$_SUBARCH"; then BASE_PARAMS+=("\"SUBARCH=$_SUBARCH\""); fi
    if ! test -z "$_BINUTILSPREFIX"; then BASE_PARAMS+=("\"BINUTILSPREFIX=$_BINUTILSPREFIX\""); fi
    if ! test -z "$_OPT"; then BASE_PARAMS+=("\"OPT=$_OPT\""); fi
    if ! test -z "$_CROSSOPT"; then BASE_PARAMS+=("CROSSOPT=\"$_CROSSOPT\""); fi
    
    PARAMS=( "compiler_cycle" "${BASE_PARAMS[@]}" "FPC=ppcx64" )
    eval make ${PARAMS[@]}

    cp -f "./compiler/$_PPCROSS" "$fpc_base_dir" 

    PARAMS=( "rtl" "packages" "${BASE_PARAMS[@]}" "FPC=$_PPCROSS" )
    eval make ${PARAMS[@]}
    PARAMS=( "rtl_install" "packages_install" "${BASE_PARAMS[@]}" "FPC=$_PPCROSS" "PREFIX=$main_dir/fpc" )
    eval make ${PARAMS[@]}
fi

cd $main_dir