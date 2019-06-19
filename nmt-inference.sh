#!/bin/bash
JOB_NAME=$1 # e.g. nmt_20190305_104416
INPUT_FILE=$2 # e.g. ./my_infer_file.ti
OUTPUT_FILE=$3 # e.g. /tmp/output_infer
JOB_DIR="gs://hacking-tigrinya-enti-cloud/$JOB_NAME/ti-en"

python -m nmt.nmt \
    --out_dir=$JOB_DIR/nmt_model \
    --inference_input_file=$INPUT_FILE \
    --inference_output_file=$OUTPUT_FILE \
    --vocab_prefix=$JOB_DIR/training-data/vocab \
    --src=ti --tgt=en
