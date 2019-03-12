#!/bin/sh

# Start shell session in Docker container
docker run -d -p 8080:8080 tensorflow-serving
