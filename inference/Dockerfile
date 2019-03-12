# Using the nightly tensorflow serving image from docker hub as base image
FROM tensorflow/serving:nightly

# Installing NGINX
RUN apt-get update && apt-get install -y --no-install-recommends nginx

# Copy model to the container
COPY .build /models/enti

# Copy NGINX configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

# ENTRYPOINT ["/bin/bash", "-c"]
# CMD ["service nginx start | tensorflow_model_server --rest_api_port=8080 --model_name=enti --model_base_path=/models/enti"]
ENTRYPOINT service nginx start | tensorflow_model_server --rest_api_port=8501 --model_name=enti --model_base_path=/models/enti
