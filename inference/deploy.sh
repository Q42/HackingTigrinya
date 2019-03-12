#!/bin/sh

# Run build script
./build.sh

# Start deployment
gcloud app deploy --project hacking-tigrinya
