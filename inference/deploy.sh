#!/bin/sh
JOB=$1
TI_EN_TIMESTAMP=$2
EN_TI_TIMESTAMP=$3
[ -z "$JOB" ] && echo "No job provided (e.g. nmt_20190312_150240)" && exit 1
[ -z "$TI_EN_TIMESTAMP" ] && echo "No timestamp for TI-EN inference NMT model provided (e.g. 1552381153042)" && exit 1
[ -z "$EN_TI_TIMESTAMP" ] && echo "No timestamp for EN-TI inference NMT model provided (e.g. 1552381153042)" && exit 1

# Run build script
./build.sh $JOB $TI_EN_TIMESTAMP $EN_TI_TIMESTAMP

# Start deployment
gcloud app deploy --project hacking-tigrinya
