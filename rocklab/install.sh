#!/bin/bash

set -e

carton install

base=$(pwd)

if carton exec perl -MLair -E'exit 0' ; then echo 'Lair is installed.'
else
    git clone --depth=1 https://github.com/giftnuss/p5-lair.git

    ( cd p5-lair
      carton exec perl Build.PL --install_base $base/local
      carton exec ./Build test
      carton exec ./Build install --install_base $base/local
    )
    rm -rf p5-lair
fi
