fairseq-generate data-bin/covost \
    --path checkpoints/checkpoint_best.pt \
    --batch-size 128 --beam 5 --remove-bpe \
    --results-path results/covost

grep ^S ./results/covost/generate-test.txt | cut -f2- > ./results/covost/sources.txt
grep ^T ./results/covost/generate-test.txt | cut -f2- > ./results/covost/target.txt
grep ^H ./results/covost/generate-test.txt | cut -f3- > ./results/covost/hypotheses.txt

python format_results_for_bleu_test.py --hypotheses ./results/covost/hypotheses.txt \
    --references ./results/covost/target.txt \
    --sources ./results/covost/sources.txt \
    --output ./results/covost/bleu_test_outputs.txt

rm ./results/covost/sources.txt ./results/covost/target.txt ./results/covost/hypotheses.txt
