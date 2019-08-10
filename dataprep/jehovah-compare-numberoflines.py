"""
doel: zeker weten dat de artikelen in beide talen hetzelfde zijn (in inhoud en
vorm) zodat we een parallelle corpus hebben en de eerste job kunnen runnen!
setup:
men neme de TI-textfile
men neme de EN-textfile
men doet er checks op
als de check passed; dan file naar subdir verplaatsen
"""

import os
import sys
import shutil

# language = sys.argv[1]

# ga eerst naar de parent folder van TI en EN (e.g. ~/Documents/wol.jw.org/)

os.chdir('data/wol.jw.org')
EN_PATH = 'en/structured_data_en_copy/bibletexts'
TI_PATH = 'ti/structured_data_ti_copy/bibletexts'
num_articles_en = len(os.listdir(EN_PATH))
num_articles_ti = len(os.listdir(TI_PATH))

# folder aanmaken voor complete files in beide talen
dest_path_articles_path_en = 'en/structured_data_en_copy/bibletexts/curated'
dest_path_articles_path_ti = 'ti/structured_data_ti_copy/bibletexts/curated'
if not os.path.exists(dest_path_articles_path_en):
    os.makedirs(dest_path_articles_path_en)
if not os.path.exists(dest_path_articles_path_ti):
    os.makedirs(dest_path_articles_path_ti)

# itereren over artikelen in Tigrinya folder
total_count_lines_en = 0
count_identical = 0
count_not_identical = 0

for article in os.listdir(TI_PATH):
    try:
        # als ze ook in de Engels folder staan, dan beide files openen
        if article in os.listdir(EN_PATH):
            with open(EN_PATH + '/' + article) as en_article:
                with open(TI_PATH + '/' + article) as ti_article:
                    # aantal regels per artikel per taal tellen en vergelijken
                    en_article_nr = sum(1 for line in en_article)
                    ti_article_nr = sum(1 for line in ti_article)
                    total_count_lines_en += en_article_nr
                    if en_article_nr == ti_article_nr:
                        count_identical += 1
                        shutil.copy(os.path.join(os.getcwd(), EN_PATH, article), os.path.join(
                            os.getcwd(), dest_path_articles_path_en, article))
                        shutil.copy(os.path.join(os.getcwd(), TI_PATH, article), os.path.join(
                            os.getcwd(), dest_path_articles_path_ti, article))
                    else:
                        print("Article {0} is not identical. \nNumber of lines in English article: {1} \nNumber of lines in Tigrinya article: {2}.".format(
                            article, en_article_nr, ti_article_nr))
                        count_not_identical += 1

    except UnicodeDecodeError:
        print('UnicodeDecodeError occurred. Going on to next textfile')
    except IsADirectoryError:
        print('IsADirectoryError occurred. Going on to next textfile')

print("Number of English articles in original directory: {0} \n Number of Tigrinya articles in original directory: {1}".format(
    num_articles_en, num_articles_ti))
print("Number of identical articles copied: {0}".format(count_identical))
print("Number of non-identical articles: {0}".format(count_not_identical))
