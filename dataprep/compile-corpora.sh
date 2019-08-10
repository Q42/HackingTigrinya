#!/bin/bash

timestamp=$(date +"%s")

python jehovah-html-text-parser.py en $timestamp
python jehovah-html-text-parser.py ti $timestamp

cat data/wol.jw.org/en/structured_data_en_copy/"$timestamp"/*.txt >> "$timestamp"_en.txt
cat data/wol.jw.org/ti/structured_data_ti_copy/"$timestamp"/*.txt >> "$timestamp"_ti.txt

wc -l "$timestamp"_en.txt
wc -l "$timestamp"_ti.txt