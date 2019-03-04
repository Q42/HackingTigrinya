#!/bin/sh

# Create package
python setup.py sdist

# Build container
docker build -t nmt .
