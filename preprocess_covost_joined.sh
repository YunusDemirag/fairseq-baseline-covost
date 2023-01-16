TEXT=examples/translation/covost
fairseq-preprocess --source-lang de --target-lang en \
    --trainpref $TEXT/train --validpref $TEXT/valid --testpref $TEXT/test \
    --destdir data-bin/covost-joined --joined-dictionary \
    --workers 20