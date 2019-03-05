gsutil cp gs://hacking-tigrinya-training-data/corpus.tar.gz /tmp

mkdir /tmp/training-data

tar -zxvf /tmp/corpus.tar.gz -C /tmp/training-data