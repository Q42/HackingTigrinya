# Setup
1. Download secrets from 1PW and copy to secrets folder.
1. Build the Docker container: `./build.sh`.
1. Start shell session in Docker container: `./run.sh`.


# Training
To kick off training jobs for both Tigrinya-English and English-Tigrinya on the GCP using CloudML, run:
```
./train-cloud.sh
```

Alternatively, you can train locally with or without using CloudML (note: these scripts will only train a Tigrinya-English model):

```
# Train locally using Cloud ML
./train-local.sh

# Train locally without using Cloud ML
./run-en-vi-example.sh
```

# Preparing training data
The training scripts grab their training data from a GCP bucket named `gs://hacking-tigrinya-training-data`. 
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

The `vocab.ti` and `vocab.en` files are generated during Docker build. The whole package then gets copied to the destination bucket `gs://hacking-tigrinya-enti-cloud` or `gs://hacking-tigrinya-enti-local` when running either of the training scripts.

# Exporting models
To use the aftermarket exporting script proposed in [this PR](https://github.com/tensorflow/nmt/pull/344) run the following. This will export models for both TI-EN and EN-TI:

```
./export-model.sh [JOB]
```

To export a [model from a checkpoint](https://stackoverflow.com/questions/45864363/tensorflow-how-to-convert-meta-data-and-index-model-files-into-one-graph-pb) run the following:
 ```
./freeze_graph.py # Optionally edit the dirs in freeze_graph.py first
```
Note that exporting a model from a checkpoint that was not created on the same machine doesn't seem to work.

# Inference

## Using Tensorflow Serving

Tensorflow Serving runs in a separate Docker container. Tensorflow Serving serves two models, one for TI-EN translation and another one for EN-TI translation.

First we need to export the trained model by running `./export-model.sh [JOB]` from within the "training Docker container". At the end of the `./export-model.sh` step above the exported models are uploaded to GCP buckets, respectively: `gs://hacking-tigrinya-enti-cloud/[JOB]/ti-en/inference_nmt_model/[TIMESTAMP]` and `gs://hacking-tigrinya-enti-cloud/[JOB]/en-ti/inference_nmt_model/[TIMESTAMP]`.

Everything else regarding inference with help of Tensorflow Serving can be found in the folder [inference](inference).

- To build the inference container run: `build.sh [JOB] [TI_EN_TIMESTAMP] [EN_TI_TIMESTAMP]`.
- To start the inference container run: `run.sh`.
- To deploy the inference container run: `deploy.sh [JOB] [TI_EN_TIMESTAMP] [EN_TI_TIMESTAMP]`.

If the server started correctly, you can now issue requests to the Tensorflow Serving server. Run `./infer-ti.sh` to issue two translation requests.

## Using NMT
Run `./nmt-inference.sh <JOB_NAME> <INPUT_FILE> <OUTPUT_FILE>` (from within the "training Docker container").

Example:
```
echo "ኣብ መዓልታዊ መደብካ ፡ እተዕርፈሉ ግዜ መድብ ። " > test.ti
./nmt-inference.sh nmt_20190305_104416 ./test.ti /tmp/test_infer
cat /tmp/test_infer
```

# Tensorboard
Open Tensorboard by running `./tensorboard.sh <JOB_NAME>` from your terminal (so not from within the Docker container), next browse to http://localhost:8888.

# Installation notes
To configure gcloud, refer to the docs here: https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu.

Note: gcloud is already installed in the Docker container.
