[ -z "$1" ] && echo "No timestamp for latest model version provided" && exit 1

rm -rf /tmp/enti
mkdir -p /tmp/enti/
gsutil -m cp -r gs://hacking-tigrinya-enti-cloud/output-enti/$1 /tmp/enti/

docker kill serving

docker pull tensorflow/serving:nightly

# Start TensorFlow Serving container and open the REST API port
docker run -t --rm -p 8501:8501 \
   -v "/tmp/enti:/models/enti" \
   -e MODEL_NAME=enti \
   --name serving \
   tensorflow/serving:nightly &
