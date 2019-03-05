#!/bin/sh

# This was a onetime thing, done on Jaap's machine to apply https://github.com/tensorflow/nmt/pull/344/ to the NMT version we use.
# cp -R ~/Projects/nmt/nmt .

# Create package
python setup.py sdist

# Build container
docker build -t nmt .
