#!/bin/sh
[ -z "$1" ] && echo "No timestamp for latest model version provided" && exit 1

BUILD_DIR=".build"

# Download exported model
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
gsutil -m cp -r gs://hacking-tigrinya-enti-cloud/output-enti/$1 $BUILD_DIR

# Build container
docker build -t tensorflow-serving .
