now=$(date +"%Y%m%d_%H%M%S")

MAIN_TRAINER_MODULE="nmt.nmt"
TRAINER_PACKAGE_PATH="/tmp/nmt-0.1.tar.gz"
BASE_DIR="gs://hacking-tigrinya-enti-cloud/nmt_$now"

# Kick off training for TI-EN
TI_EN_JOB_NAME="nmt_ti_en_$now"
TI_EN_JOB_DIR="$BASE_DIR/ti-en"
TI_EN_OUT_DIR="$BASE_DIR/ti-en/nmt_model"
gsutil cp -r /tmp/training-data/ $TI_EN_JOB_DIR/training-data
gcloud ml-engine jobs submit training $TI_EN_JOB_NAME \
    --module-name $MAIN_TRAINER_MODULE \
    --packages $TRAINER_PACKAGE_PATH \
    --job-dir $TI_EN_JOB_DIR \
    --runtime-version 1.12 \
    -- \
    --check_special_token=False \
    --src=ti --tgt=en \
    --vocab_prefix=$TI_EN_JOB_DIR/training-data/vocab  \
    --train_prefix=$TI_EN_JOB_DIR/training-data/training \
    --dev_prefix=$TI_EN_JOB_DIR/training-data/test  \
    --test_prefix=$TI_EN_JOB_DIR/training-data/validation \
    --out_dir=$TI_EN_OUT_DIR \
    --num_train_steps=20000 \
    --steps_per_stats=100 \
    --num_layers=2 \
    --num_units=512 \
    --dropout=0.2 \
    --batch_size=64 \
    --subword_option=spm \
    --infer_mode=beam_search \
    --beam_width=10 \
    --attention=scaled_luong \
    --optimizer=adam \
    --init_op=glorot_uniform \
    --warmup_steps=5000 \
    --decay_scheme=luong234 \
    --metrics=bleu

# Kick off training for EN-TI
EN_TI_JOB_NAME="nmt_en_ti_$now"
EN_TI_JOB_DIR="$BASE_DIR/en-ti"
EN_TI_OUT_DIR="$BASE_DIR/en-ti/nmt_model"
gsutil cp -r /tmp/training-data/ $EN_TI_JOB_DIR/training-data
gcloud ml-engine jobs submit training $EN_TI_JOB_NAME \
    --module-name $MAIN_TRAINER_MODULE \
    --packages $TRAINER_PACKAGE_PATH \
    --job-dir $EN_TI_JOB_DIR \
    --runtime-version 1.12 \
    -- \
    --check_special_token=False \
    --src=en --tgt=ti \
    --vocab_prefix=$EN_TI_JOB_DIR/training-data/vocab  \
    --train_prefix=$EN_TI_JOB_DIR/training-data/training \
    --dev_prefix=$EN_TI_JOB_DIR/training-data/test  \
    --test_prefix=$EN_TI_JOB_DIR/training-data/validation \
    --out_dir=$EN_TI_OUT_DIR \
    --num_train_steps=20000 \
    --steps_per_stats=100 \
    --num_layers=2 \
    --num_units=512 \
    --dropout=0.2 \
    --batch_size=64 \
    --subword_option=spm \
    --infer_mode=beam_search \
    --beam_width=10 \
    --attention=scaled_luong \
    --optimizer=adam \
    --init_op=glorot_uniform \
    --warmup_steps=5000 \
    --decay_scheme=luong234 \
    --metrics=bleu
