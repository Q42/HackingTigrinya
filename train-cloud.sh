now=$(date +"%Y%m%d_%H%M%S")
JOB_NAME="nmt_$now"
MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="/tmp/nmt-0.1.tar.gz"
JOB_DIR="gs://hacking-tigrinya-enti-cloud"
OUT_DIR="gs://hacking-tigrinya-enti-cloud/nmt_model"

gsutil cp /tmp/training-data/vocab.* $JOB_DIR/training-data

gcloud ml-engine jobs submit training $JOB_NAME \
    --module-name $MAIN_TRAINER_MODULE \
    --packages $TRAINER_PACKAGE_PATH \
    --job-dir $JOB_DIR \
    --runtime-version 1.12 \
    -- \
    --check_special_token=False \
    --src=ti --tgt=en \
    --vocab_prefix=$JOB_DIR/training-data/vocab  \
    --train_prefix=$JOB_DIR/training-data/training \
    --dev_prefix=$JOB_DIR/training-data/test  \
    --test_prefix=$JOB_DIR/training-data/validation \
    --out_dir=$OUT_DIR \
    --num_train_steps=12000 \
    --steps_per_stats=100 \
    --num_layers=2 \
    --num_units=128 \
    --dropout=0.2 \
    --batch_size=64 \
    --metrics=bleu