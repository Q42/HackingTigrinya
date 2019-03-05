# mkdir -p /tmp/envi/

# gsutil -m cp -r gs://hacking-tigrinya-cloud/output-envi/1551800476731 /tmp/envi/

# Download the TensorFlow Serving Docker image and repo
# docker pull tensorflow/serving:nightly

# git clone https://github.com/tensorflow/serving

# Start TensorFlow Serving container and open the REST API port
# docker run -t --rm -p 8501:8501 \
#    -v "/tmp/envi:/models/envi" \
#    -e MODEL_NAME=envi \
#    tensorflow/serving:nightly &

# Query the model using the predict API
# curl -d '{"instances": ["Xin chào tôi tên là Leonard", "Khoa học đằng sau một tiêu đề về khí hậu"]}' -X POST http://localhost:8501/v1/models/envi:predict

# Returns => { "predictions": [2.5, 3.0, 4.5] }
