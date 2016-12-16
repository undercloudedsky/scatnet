#!/usr/bin/env bash
if [ -z "$MATLABPATH" ];then
    MATLABPATH=$PWD
else
    MATLABPATH="$PWD:$MATLABPATH"
fi
export MATLABPATH
