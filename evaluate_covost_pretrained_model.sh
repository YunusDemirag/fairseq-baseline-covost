fairseq-generate data-bin/covost \
    --path data-bin/wmt14.en-fr.fconv-py/model.pt \
    --beam 5 --batch-size 128 --remove-bpe | tee /tmp/gen.out
    --results-path results/covost/pretrained

grep ^S ./results/covost/pretrained/generate-test.txt | cut -f2- > ./results/covost/pretrained/sources.txt
grep ^T ./results/covost/pretrained/generate-test.txt | cut -f2- > ./results/covost/pretrained/target.txt
grep ^H ./results/covost/pretrained/generate-test.txt | cut -f3- > ./results/covost/pretrained/hypotheses.txt

python format_results_for_bleu_test.py --hypotheses ./results/covost/pretrained/hypotheses.txt \
    --references ./results/covost/pretrained/target.txt \
    --sources ./results/covost/pretrained/sources.txt \
    --output ./results/covost/pretrained/bleu_test_outputs.txt

rm ./results/covost/pretrained/sources.txt ./results/covost/pretrained/target.txt ./results/covost/pretrained/hypotheses.txt