#!/bin/sh
JOB=$1
[ -z "$JOB" ] && echo "No job provided (e.g. nmt_20190312_150240)" && exit 1

MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="nmt"

# Export inference model for TI-EN
TI_EN_JOB_DIR="/tmp/$JOB/ti-en"
TI_EN_OUT_DIR="$TI_EN_JOB_DIR/nmt_model"
TI_EN_EXPORT_DIR="$TI_EN_JOB_DIR/exported_nmt_model"
gcloud ml-engine local train \
    --module-name $MAIN_TRAINER_MODULE \
    --package-path $TRAINER_PACKAGE_PATH \
    --job-dir $TI_EN_JOB_DIR \
    -- \
    --out_dir=$TI_EN_OUT_DIR \
    --export_path=$TI_EN_EXPORT_DIR \
    --ckpt_path=$TI_EN_OUT_DIR \
    --vocab_prefix=$TI_EN_OUT_DIR/training-data/vocab

# Export inference model for EN-TI
EN_TI_JOB_DIR="/tmp/$JOB/en-ti"
EN_TI_OUT_DIR="$EN_TI_JOB_DIR/nmt_model"
EN_TI_EXPORT_DIR="$EN_TI_JOB_DIR/exported_nmt_model"
gcloud ml-engine local train \
    --module-name $MAIN_TRAINER_MODULE \
    --package-path $TRAINER_PACKAGE_PATH \
    --job-dir $EN_TI_JOB_DIR \
    -- \
    --out_dir=$EN_TI_OUT_DIR \
    --export_path=$EN_TI_EXPORT_DIR \
    --ckpt_path=$EN_TI_OUT_DIR \
    --vocab_prefix=$EN_TI_OUT_DIR/training-data/vocab

# Upload inference models
gsutil -m cp -r $TI_EN_EXPORT_DIR/* gs://hacking-tigrinya-enti-cloud/$JOB/ti-en/inference_nmt_model/
gsutil -m cp -r $EN_TI_EXPORT_DIR/* gs://hacking-tigrinya-enti-cloud/$JOB/en-ti/inference_nmt_model/
