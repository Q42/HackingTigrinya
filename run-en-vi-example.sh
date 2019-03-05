python -m nmt.nmt \
    --src=ti --tgt=en \
    --vocab_prefix=/tmp/training-data/vocab  \
    --train_prefix=/tmp/training-data/training \
    --dev_prefix=/tmp/training-data/test  \
    --test_prefix=/tmp/training-data/validation \
    --out_dir=/tmp/nmt_model \
    --check_special_token=False \
    --num_train_steps=12000 \
    --steps_per_stats=100 \
    --num_layers=2 \
    --num_units=128 \
    --dropout=0.2 \
    --batch_size=64 \
    --metrics=bleu