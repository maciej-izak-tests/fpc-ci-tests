#!/bin/bash
# This file is part of the Free Pascal CI system.
# Copyright (c) 2017 by Maciej Izak
# member of the Free Pascal development team

# additional tools
mkdir tools
cd tools
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
chmod ugo+x jq
cd ..

# download bootstrap compiler (must be located in separate directory)
mkdir bootstrap
cd bootstrap
wget https://github.com/maciej-izak/fpc-ci-tests/releases/download/download/ppcx64-linux
chmod ugo+x ppcx64-linux
cd ..