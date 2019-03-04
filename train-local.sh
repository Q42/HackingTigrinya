MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="nmt"
JOB_DIR="gs://hacking-tigrinya"
OUT_DIR="gs://hacking-tigrinya/nmt_model"

gcloud ml-engine local train \
    --module-name $MAIN_TRAINER_MODULE \
    --package-path $TRAINER_PACKAGE_PATH \
    --job-dir $JOB_DIR \
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