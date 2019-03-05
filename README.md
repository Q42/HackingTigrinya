# Setup
1. Download secrets from 1PW and copy to secrets folder.
1. Build the Docker container: `./build.sh`.
1. Start shell session in Docker container: `./run.sh`.


# Run example
Run the English/Vietnamese example as follows:

## Train locally without using Cloud ML
```
cd /src
./run-en-vi-example.sh
```

## Train locally using Cloud ML
```
cd /src
./train-local.sh
```

## Train in cloud using Cloud ML
```
cd /src
./train-cloud.sh
```

# Preparing training data
The training script grab their training data from a GCP bucket named `gs://hacking-tigrinya-training-data`. 
To put the data there, download the data from drive https://drive.google.com/drive/u/0/folders/1R39NougcbNncesDb_ndUhONKWWjbawo- and put it in a tarball.

The scripts expect the tar to contain the following files:
```
- training.ti
- training.en
- test.ti
- test.en
- validation.ti
- validation.en
```

To make the tarball, `cd` to the directory where these files are and run `tar -zcvf ~/Downloads/corpus.tar.gz .` (where `~/Downloads/corpus.tar.gz` is the destination file).

The `vocab.ti` and `vocab.en` files are generated during Docker build. The whole package then get's copied to the destination bucket `gs://hacking-tigrinya-enti-cloud` or `gs://hacking-tigrinya-enti-local` when running either of the train scripts.

# Exporting model
To use the aftermarket exporting script proposed in [https://github.com/tensorflow/nmt/pull/344](this PR) run the following:

```
cd /src
./export-model.sh
```

# Tensorboard
Open Tensorboard by running `./tensorboard.sh`, next browse to http://localhost:8888.

# Installation notes
To configure gcloud, refer to the docs here: https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu.

Note: gcloud is already installed in the Docker container.
