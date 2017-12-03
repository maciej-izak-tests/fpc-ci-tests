#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

# initialization for basic variables
export TEST_MAIN_PARAMS=($TEST_MAIN_PARAMS)
export main_dir=`pwd`
export fpc_base_dir=$main_dir'/fpc/lib/fpc/3.1.1'
export PATH=$main_dir/tools:$main_dir/binutils/bin:$main_dir/fpc/bin:$fpc_base_dir:$PATH
export bootstrap=FPC=$main_dir/bootstrap/ppcx64-linux
export installprefix=INSTALL_PREFIX=$main_dir/fpc
export repozip=$(cat cfg.json | \jq -r '.| "\(.ref).zip"')
export repourl=$(cat cfg.json | \jq -r '.| "https://github.com/\(.owner)/\(.repo)/archive/\(env.repozip)"')
export binutils_ver=$(jq -r .binutils_ver cfg.json)
export fpcsrc=$(cat cfg.json | \jq -r '.| "\(.repo)-\(.ref)"')