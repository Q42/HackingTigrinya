mkdir -p /tmp/envi
gsutil -m cp -r gs://hacking-tigrinya-cloud /tmp/envi/

MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="nmt"

JOB_DIR="/tmp/envi/hacking-tigrinya-cloud/"
OUT_DIR="/tmp/envi/hacking-tigrinya-cloud/nmt_model/"


gcloud ml-engine local train \
    --module-name $MAIN_TRAINER_MODULE \
    --package-path $TRAINER_PACKAGE_PATH \
    --job-dir $JOB_DIR \
    -- \
    --out_dir=$OUT_DIR \
    --export_path=$OUT_DIR \
    --ckpt_path=$OUT_DIR