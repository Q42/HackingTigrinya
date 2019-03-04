FROM tensorflow/tensorflow:nightly

RUN apt-get -y install curl wget

ADD nmt /nmt/ 