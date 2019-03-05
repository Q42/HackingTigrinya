#!/bin/bash
JOB_NAME=$1 # e.g. nmt_20190305_104416
INPUT_FILE=$2 # e.g. ./my_infer_file.ti
OUTPUT_FILE=$3 # e.g. /tmp/output_infer
OUT_DIR="gs://hacking-tigrinya-enti-cloud/$JOB_NAME/nmt_model"

python -m nmt.nmt \
    --out_dir=$OUT_DIR \
    --inference_input_file=$INPUT_FILE \
    --inference_output_file=$OUTPUT_FILE
