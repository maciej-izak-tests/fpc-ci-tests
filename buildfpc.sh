#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

set -ev

#    "https://github.com/newpascal/freepascal/archive/69bab7793fdca65861d1c34f3d148f8bc8c76bdc.zip"
#    "https://github.com/newpascal/freepascal/archive/10b7cc37f8e3651ecae871464ae1a5d2833fb080.zip"
#    "https://github.com/newpascal/freepascal/archive/7040d6de9b614d8a8f34e1f8404f66627ea76220.zip"

wget $repourl
unzip -qq $repozip
cd $fpcsrc
make all $bootstrap
make install $bootstrap $installprefix 
chmod -R 777 $main_dir/fpc/bin
sudo $fpc_base_dir/samplecfg $fpc_base_dir