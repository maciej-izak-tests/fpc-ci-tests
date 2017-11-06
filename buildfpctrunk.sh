#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

wget https://github.com/newpascal/freepascal/archive/freepascal.zip
unzip -qq freepascal.zip
cd freepascal-freepascal
make all $bootstrap
make install $bootstrap $installprefix 
chmod -R 777 $main_dir/fpc/bin
sudo $fpc_base_dir/samplecfg $fpc_base_dir