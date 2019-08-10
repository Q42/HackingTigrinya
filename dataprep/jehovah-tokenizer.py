"""
doel: van zowel engelse als tigrinya tekstbestanden de interpunctie loszetten van tekst
setup:
-over iedere textfile itereren
-alle interpunctie loszetten van tekst in gehele bestand
-nieuw bestand schrijven als <originelenaam>_tokenized.txt
"""
import os
import sys
import shutil
import re

from nltk.tokenize import word_tokenize

language = sys.argv[1]

os.chdir('wget-scraped/wol.jw.org')
EN_PATH = 'en/structured_data_en_copy/bibletexts/curated'
TI_PATH = 'ti/structured_data_ti_copy/bibletexts/curated'

if language == "en":
    os.chdir(EN_PATH)
    if not os.path.exists('tokenized'):
        os.makedirs('tokenized')
    for article in os.listdir(os.getcwd()):
        try:
            with open(article, "r") as f_in, open(os.path.join('tokenized', article), "w+") as f_out:
                for line in f_in:
                    line_n = line.replace('+', '').replace('*', '') #these characters seem to appear a lot. they screw up the tokenization because of appearing along with other punctuation, resulting in the tokenizer leaving a token with special characters in it.
                    newline = " ".join(word_tokenize(line_n))
                    f_out.write(newline + "\n")
        except UnicodeDecodeError:
            print('UnicodeDecodeError occurred. Going on to next textfile')
        except IsADirectoryError:
            print('IsADirectoryError occurred. Going on to next textfile')

if language == "ti":
    SPECIAL_CHARACTERS = '፠፡።፣፤፥፦፧፨'
    os.chdir(TI_PATH)
    if not os.path.exists('tokenized'):
        os.makedirs('tokenized')
    for article in os.listdir(os.getcwd()):
        try:
            with open(article, "r") as f_in, open(os.path.join('tokenized', article), "w+") as f_out:
                for line in f_in:
                    line = line.replace('+', '').replace('*', '')
                    newline = " ".join(word_tokenize(line))
                    for char in newline:
                        if char in SPECIAL_CHARACTERS:
                            newline = newline.replace(char, ' '+char+' ')
                            newline = re.sub(' +',' ', newline)
                    f_out.write(newline + "\n")
        except UnicodeDecodeError:
            print('UnicodeDecodeError occurred. Going on to next textfile')
        except IsADirectoryError:
            print('IsADirectoryError occurred. Going on to next textfile')
