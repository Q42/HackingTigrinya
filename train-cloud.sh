now=$(date +"%Y%m%d_%H%M%S")
JOB_NAME="nmt_$now"
MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="/tmp/nmt-0.1.tar.gz"
JOB_DIR="gs://hacking-tigrinya-cloud"
OUT_DIR="gs://hacking-tigrinya-cloud/nmt_model"

gcloud ml-engine jobs submit training $JOB_NAME \
    --module-name $MAIN_TRAINER_MODULE \
    --packages $TRAINER_PACKAGE_PATH \
    --job-dir $JOB_DIR \
    --runtime-version 1.12 \
    -- \
    --src=vi --tgt=en \
    --vocab_prefix=gs://hacking-tigrinya/vocab  \
    --train_prefix=gs://hacking-tigrinya/train \
    --dev_prefix=gs://hacking-tigrinya/tst2012  \
    --test_prefix=gs://hacking-tigrinya/tst2013 \
    --out_dir=$OUT_DIR \
    --num_train_steps=12000 \
    --steps_per_stats=100 \
    --num_layers=2 \
    --num_units=128 \
    --dropout=0.2 \
    --metrics=bleu