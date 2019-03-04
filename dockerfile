FROM tensorflow/tensorflow:nightly

RUN apt-get -y install curl wget

ADD nmt /src/nmt/

RUN /src/nmt/scripts/download_iwslt15.sh /tmp/nmt_data
RUN mkdir /tmp/nmt_model

ADD run-en-vi-example.sh /src/
