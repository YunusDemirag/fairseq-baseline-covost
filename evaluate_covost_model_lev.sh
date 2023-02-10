fairseq-generate \
    data-bin/covost-joined \
    --gen-subset test \
    --task translation_lev \
    --path checkpoints/levenshtein_transformer/checkpoint_best.pt \
    --iter-decode-max-iter 9 \
    --iter-decode-eos-penalty 0 \
    --beam 1 --remove-bpe \
    --print-step \
    --batch-size 400 \
    --results-path results/covost/levenshtein_transformer

grep ^S ./results/covost/levenshtein_transformer/generate-test.txt | cut -f2- > ./results/covost/levenshtein_transformer/sources.txt
grep ^T ./results/covost/levenshtein_transformer/generate-test.txt | cut -f2- > ./results/covost/levenshtein_transformer/target.txt
grep ^H ./results/covost/levenshtein_transformer/generate-test.txt | cut -f3- > ./results/covost/levenshtein_transformer/hypotheses.txt

python format_results_for_bleu_test.py --hypotheses ./results/covost/levenshtein_transformer/hypotheses.txt \
    --references ./results/covost/levenshtein_transformer/target.txt \
    --sources ./results/covost/levenshtein_transformer/sources.txt \
    --output ./results/covost/levenshtein_transformer/bleu_test_outputs.txt

rm ./results/covost/levenshtein_transformer/sources.txt ./results/covost/levenshtein_transformer/target.txt ./results/covost/levenshtein_transformer/hypotheses.txt
