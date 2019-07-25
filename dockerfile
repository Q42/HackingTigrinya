FROM tensorflow/tensorflow:nightly

# Install some dependencies
RUN apt-get -y install curl wget lsb-release nano

# Install GCloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# GCloud SDK initialisation
ADD secrets/gcloud-sdk-service-account.json /secrets/
RUN gcloud config configurations create default
RUN gcloud auth activate-service-account --key-file /secrets/gcloud-sdk-service-account.json
RUN gcloud config set project hacking-tigrinya
RUN gcloud config set compute/region europe-west1
ENV GOOGLE_APPLICATION_CREDENTIALS="/secrets/gcloud-sdk-service-account.json"

# Copy sources
COPY nmt /src/nmt/
COPY generate-vocab.py download-trainingdata.sh run-en-vi-example.sh train-local.sh train-cloud.sh nmt-inference.sh freeze_graph.py export-model.sh /src/
COPY dist/nmt-0.1.tar.gz /tmp/

# Download training data
RUN chmod +x /src/download-trainingdata.sh
RUN /src/download-trainingdata.sh

# Generate vocabulary
# Disabled for now, since in the corpus v3, the vocab files are part of the archive we download in the previous step
# RUN python /src/generate-vocab.py --max_vocab_size 17000 /tmp/training-data/training.en > /tmp/training-data/vocab.en
# RUN python /src/generate-vocab.py --max_vocab_size 17000 /tmp/training-data/training.ti > /tmp/training-data/vocab.ti
# We still need to extract only the first column from those vocab files though
RUN mv /tmp/training-data/vocab.en /tmp/training-data/vocab-with-count.en
RUN mv /tmp/training-data/vocab.ti /tmp/training-data/vocab-with-count.ti
RUN cut -f 1 /tmp/training-data/vocab-with-count.en > /tmp/training-data/vocab.en
RUN cut -f 1 /tmp/training-data/vocab-with-count.ti > /tmp/training-data/vocab.ti

# Temp add data for exporting
# COPY test /tmp/nmt_20190607_151042/

WORKDIR /src/
