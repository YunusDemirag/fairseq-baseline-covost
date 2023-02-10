fairseq-generate data-bin/covost \
    --path checkpoints/transformer/checkpoint_last.pt \
    --batch-size 64 --beam 10 --remove-bpe \
    --results-path results/covost/transformer

grep ^S ./results/covost/transformer/generate-test.txt | cut -f2- > ./results/covost/transformer/sources.txt
grep ^T ./results/covost/transformer/generate-test.txt | cut -f2- > ./results/covost/transformer/target.txt
grep ^H ./results/covost/transformer/generate-test.txt | cut -f3- > ./results/covost/transformer/hypotheses.txt

python format_results_for_bleu_test.py --hypotheses ./results/covost/transformer/hypotheses.txt \
    --references ./results/covost/transformer/target.txt \
    --sources ./results/covost/transformer/sources.txt \
    --output ./results/covost/transformer/bleu_test_outputs.txt

rm ./results/covost/transformer/sources.txt ./results/covost/transformer/target.txt ./results/covost/transformer/hypotheses.txt
