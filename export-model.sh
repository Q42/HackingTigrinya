mkdir -p /tmp/enti
gsutil -m cp -r gs://hacking-tigrinya-enti-cloud/nmt_20190305_104416 /tmp/enti/

MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="nmt"

JOB_DIR="/tmp/enti/nmt_20190305_104416"
OUT_DIR="$JOB_DIR/nmt_model"
EXPORT_DIR="$JOB_DIR/exported_nmt_model"

gcloud ml-engine local train \
    --module-name $MAIN_TRAINER_MODULE \
    --package-path $TRAINER_PACKAGE_PATH \
    --job-dir $JOB_DIR \
    -- \
    --out_dir=$OUT_DIR \
    --export_path=$EXPORT_DIR \
    --ckpt_path=$OUT_DIR

gsutil -m cp -r $EXPORT_DIR/ gs://hacking-tigrinya-enti-cloud/output-enti