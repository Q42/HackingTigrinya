Build the Dockerfile with `docker build -t nmt .`

Run with `docker run -it -p 8888:8888 nmt`.

Run the English/Vietnamese examply as follows:

```
cd /src
./run-en-vi-example.sh
```

----

To configure gcloud, refer to the docs here: https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
Note: gcloud is already installed in the Docker container.