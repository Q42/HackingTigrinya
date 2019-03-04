FROM tensorflow/tensorflow:nightly

RUN apt-get -y install curl wget lsb-release

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

ADD nmt /src/nmt/

RUN /src/nmt/scripts/download_iwslt15.sh /tmp/nmt_data
RUN mkdir /tmp/nmt_model

# GCloud SDK initialisation
ADD secrets/gcloud-sdk-service-account.json /secrets/
RUN gcloud config configurations create default
RUN gcloud auth activate-service-account --key-file /secrets/gcloud-sdk-service-account.json
RUN gcloud config set project hacking-tigrinya

ADD run-en-vi-example.sh /src/
