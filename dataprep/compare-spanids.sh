#!/bin/bash

for path in data/wol.jw.org/en/structured_data_en_copy/spanids/*.txt; do
    filename=$(basename "$path")
    diff $path data/wol.jw.org/ti/structured_data_ti_copy/spanids/$filename
done