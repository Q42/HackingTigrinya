import os

os.chdir('data/wol.jw.org')
EN_PATH = 'en/structured_data_en_copy/bibletexts/curated/tokenized'  # change path here
TI_PATH = 'ti/structured_data_ti_copy/bibletexts/curated/tokenized'  # change path here
num_articles_en = len(os.listdir(EN_PATH))
num_articles_ti = len(os.listdir(TI_PATH))

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
