import unicodedata
import re

COVOST_PATH = "./examples/translation/covost"

def replace_german_special_chars(string: str) -> str:

    replacements = {
        'ä':"ae",
        'ü':"ue",
        'ö':"oe",
        'ß':"ss"
    }

    for char, replacement in replacements.items():
        string = string.replace(char, replacement)
        
    return string

# function to remove special characters
def remove_special_characters(text):
    # define the pattern to keep
    regex = r'[^a-zA-z0-9.,!?/:;\"\'\s\-]' 
    return re.sub(regex, '', text)

def remove_accented_chars(text):
    new_text = unicodedata.normalize('NFKD', text).encode('ascii', 'ignore').decode('utf-8', 'ignore')
    return new_text

## Create tmp folder if not exists
import os
if not os.path.exists(f'{COVOST_PATH}/tmp'):
    os.makedirs(f'{COVOST_PATH}/tmp')

for split in ['dev', 'test', 'train']:
    with open(f'{COVOST_PATH}/covost_v2.de_en.{split}.tsv', 'r') as tsv, open(f'{COVOST_PATH}/tmp/{split}.de', 'w') as txt_de, open(f'{COVOST_PATH}/tmp/{split}.en', 'w') as txt_en :
        for line in tsv.readlines():
            _path, sentence, translation, _client_id, *_ = line.split('\t')
            sentence_no_german_chars = replace_german_special_chars(sentence)
            sentence_no_special_chars = remove_special_characters(sentence_no_german_chars)
            sentence_no_special_chars = remove_accented_chars(sentence_no_special_chars)
            translation_no_special_chars = remove_special_characters(translation)
            translation_no_special_chars = remove_accented_chars(translation_no_special_chars)
            txt_de.write(sentence_no_special_chars + '\n')
            txt_en.write(translation_no_special_chars + '\n')