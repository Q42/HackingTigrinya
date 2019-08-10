#!/bin/bash

LANG=$1
for filename in data/wol.jw.org/"$LANG"/structured_data_"$LANG"_copy/spanids/*.txt; do
    LINES=`cat "$filename" | wc -l`
    echo "$filename $LINES"
done