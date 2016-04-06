#!/bin/bash

__DIR__=$(cd $(dirname $BASH_SOURCE[0]) && pwd)

#tlmgr conf texmf TEXMFHOME "${__DIR__}/texmf"

export TEXMFHOME
TEXMFHOME=${__DIR__}/texmf

#pdflatex schulschriften.tex

