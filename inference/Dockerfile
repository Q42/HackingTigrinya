# Using the nightly tensorflow serving image from docker hub as base image
FROM tensorflow/serving:nightly

# Installing NGINX
RUN apt-get update && apt-get install -y --no-install-recommends nginx

# Copy model and configuration to the container
COPY .build /models/
COPY models.conf /models

# Copy NGINX configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT service nginx start | tensorflow_model_server --rest_api_port=8501 --model_config_file=/models/models.conf
