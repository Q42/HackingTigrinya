#!/bin/sh
JOB=$1
TI_EN_TIMESTAMP=$2
EN_TI_TIMESTAMP=$3
[ -z "$JOB" ] && echo "No job provided (e.g. nmt_20190312_150240)" && exit 1
[ -z "$TI_EN_TIMESTAMP" ] && echo "No timestamp for TI-EN inference NMT model provided (e.g. 1552381153042)" && exit 1
[ -z "$EN_TI_TIMESTAMP" ] && echo "No timestamp for EN-TI inference NMT model provided (e.g. 1552381153042)" && exit 1


BUILD_DIR=".build"

# Download exported model
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/ti-en
mkdir -p $BUILD_DIR/en-ti
gsutil -m cp -r gs://hacking-tigrinya-enti-cloud/$JOB/ti-en/inference_nmt_model/$TI_EN_TIMESTAMP $BUILD_DIR/ti-en
gsutil -m cp -r gs://hacking-tigrinya-enti-cloud/$JOB/en-ti/inference_nmt_model/$EN_TI_TIMESTAMP $BUILD_DIR/en-ti

# Build container
docker build -t tensorflow-serving .
