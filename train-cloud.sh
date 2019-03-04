gcloud ml-engine jobs submit training attempt9_06_06 \\
    --module-name nmt.nmt \\
    --job-dir gs://hacking-tigrinya/ \\
    --packages ~/Downloads/test2.tar \\
    --runtime-version 1.8 \\
    -- \\
    --src=vi --tgt=en \\
    --vocab_prefix=gs://hacking-tigrinya/vocab  \\
    --train_prefix=gs://hacking-tigrinya/train \\
    --dev_prefix=gs://hacking-tigrinya/tst2012  \\
    --test_prefix=gs://hacking-tigrinya/tst2013 \\
    --out_dir=gs://hacking-tigrinya/nmt_model \\
    --num_train_steps=12000 \\
    --steps_per_stats=100 \\
    --num_layers=2 \\
    --num_units=128 \\
    --dropout=0.2 \\
    --metrics=bleu



gcloud ml-engine jobs submit training attempt10_06_06 \\
    --module-name nmt.nmt \\
    --job-dir gs://hacking-tigrinya/ \\
    --packages ~/Downloads/test.tar \\
    --runtime-version 1.8 \\
    -- \\
    --src=vi --tgt=en \\
    --vocab_prefix=gs://hacking-tigrinya/vocab  \\
    --train_prefix=gs://hacking-tigrinya/train \\
    --dev_prefix=gs://hacking-tigrinya/tst2012  \\
    --test_prefix=gs://hacking-tigrinya/tst2013 \\
    --out_dir=gs://hacking-tigrinya/nmt_model \\
    --num_train_steps=12000 \\
    --steps_per_stats=100 \\
    --num_layers=2 \\
    --num_units=128 \\
    --dropout=0.2 \\
    --metrics=bleu