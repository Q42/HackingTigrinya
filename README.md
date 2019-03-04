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

## Tain in cloud using Cloud ML
```
cd /src
./train-cloud.sh
```

# Installation notes
To configure gcloud, refer to the docs here: https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu

Note: gcloud is already installed in the Docker container.
