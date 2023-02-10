import json
import argparse

parser = argparse.ArgumentParser(
    description='Format results for BLEU test'
)

parser.add_argument(
    '--hypotheses',
    type=str,
    help='Path to hypothesis file'
)

parser.add_argument(
    '--references',
    type=str,
    help='Path to references file'
)

parser.add_argument(
    '--sources',
    type=str,
    help='Path to sources file'
)

parser.add_argument(
    '--output',
    type=str,
    help='Path to output file'
)

args = parser.parse_args()

hypotheses_file = open(args.hypotheses, 'r')

hypotheses = (hypothesis.split('\n')[0] for hypothesis in hypotheses_file)

references_file = open(args.references, 'r')

references = (reference.split('\n')[0] for reference in references_file)

sources_file = open(args.sources, 'r')

sources = (source.split('\n')[0] for source in sources_file)

source_hypothesis_reference = zip(sources, hypotheses, references)

with open(args.output, 'w') as f:
    for source, hypothesis, reference in source_hypothesis_reference:
        object = {
            'src': source,
            'trg': hypothesis,
            'reference': reference
        }

        f.write(json.dumps(object) + '\n')

hypotheses_file.close()
references_file.close()
sources_file.close()