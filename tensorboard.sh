#!/bin/sh
JOB_NAME=$1 # e.g. nmt_20190305_104416
OUT_DIR="gs://hacking-tigrinya-enti-cloud/$JOB_NAME"

docker run -it -p 8888:8888 nmt tensorboard --logdir=$OUT_DIR --port 8888
