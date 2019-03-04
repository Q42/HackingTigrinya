#!/bin/sh

docker run -it -p 8888:8888 nmt tensorboard --logdir=gs://hacking-tigrinya-cloud --port 8888
