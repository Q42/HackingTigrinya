[ -z "$1" ] && echo "No timestamp for latest model version provided" && exit 1

rm -rf /tmp/envi
mkdir -p /tmp/envi/
gsutil -m cp -r gs://hacking-tigrinya-cloud/output-envi/$1 /tmp/envi/

docker kill serving

docker pull tensorflow/serving:nightly

# Start TensorFlow Serving container and open the REST API port
docker run -t --rm -p 8501:8501 \
   -v "/tmp/envi:/models/envi" \
   -e MODEL_NAME=envi \
   --name serving \
   tensorflow/serving:nightly &
