"""
setup:
alle html's uit <root taaldirectory>/structured openen
nieuw <boek><hoofdstuk>.txt maken
tekst uit <article> halen en iedere <p> op nieuwe regel van <boek><hoofdstuk>.txt zetten

"""

import os
import sys
import bs4

# navigeren naar juiste dir (taal door user aan te geven)
# files openen: loopen over alle files in dir
# files text fixen: BeautifulSoup gebruiken
# nieuwe files opslaan in subfolder

language = sys.argv[1]
subdir = sys.argv[2]

main_language_dir = os.path.join(
    os.getcwd(), "data/wol.jw.org/{0}/structured_data_{0}_copy".format(language))
os.chdir(main_language_dir)

if language == 'en':
    if not os.path.exists(os.path.join(main_language_dir, str(subdir))):
        os.makedirs(os.path.join(main_language_dir, str(subdir)))
    # print(os.listdir(os.getcwd())[1])
    # jehovahSoup = bs4.BeautifulSoup(open(os.listdir(os.getcwd())[1]), features="html.parser")
    # jehovahArticleSoupRaw = jehovahSoup.article
    # for i in jehovahArticleSoupRaw.find_all('p'):
    #     print(i.get_text())

    for html_file in os.listdir(os.getcwd()):
        try:
            print('Starting with article {0}'.format(html_file))
            jehovahSoup = bs4.BeautifulSoup(
                open(html_file), features="html.parser")
            jehovahArticleSoupRaw = jehovahSoup.article
            with open(os.path.join(str(subdir), "{0}.txt".format(html_file)), "w+") as target_textfile:
                for i in jehovahArticleSoupRaw.find_all('span', {'class': 'v'}):
                    for span in i.find_all("span", {'class': 'vl'}):
                        span.decompose()

                    for span in i.find_all("span", {'class': 'cl'}):
                        span.decompose()

                    for link in i.find_all("a", {'class': 'vp'}):
                        link.decompose()

                    target_textfile.write(i.get_text() + '\n')

                # for i in jehovahArticleSoupRaw.find_all('p'):
                #     for span in i.find_all("span", {'class': 'vl'}):
                #         span.decompose()

                #     for span in i.find_all("span", {'class': 'cl'}):
                #         span.decompose()

                #     for link in i.find_all("a", {'class': 'vp'}):
                #         link.decompose()

                #     for j in i.find_all('span', {'class': 'v'}):
                #         target_textfile.write(j.get_text() + '\n')
                target_textfile.close()
        except UnicodeDecodeError:
            print('UnicodeDecodeError occurred. Going on to next textfile')
        except IsADirectoryError:
            print('IsADirectoryError occurred. Going on to next textfile')


# with open("bla.txt", "w+") as test_file:
#     for i in jehovahArticleSoupRaw.find_all('p'):
#         test_file.write(i.get_text() + '\n')
#     test_file.close()


if language == 'ti':
    if not os.path.exists(os.path.join(main_language_dir, str(subdir))):
        os.makedirs(os.path.join(main_language_dir, str(subdir)))

    for html_file in os.listdir(os.getcwd()):
        try:
            print('Starting with article {0}'.format(html_file))
            jehovahSoup = bs4.BeautifulSoup(
                open(html_file), features="html.parser")
            jehovahArticleSoupRaw = jehovahSoup.article
            with open(os.path.join(str(subdir), "{0}.txt".format(html_file)), "w+") as target_textfile:
                for i in jehovahArticleSoupRaw.find_all('span', {'class': 'v'}):
                    for span in i.find_all("span", {'class': 'vl'}):
                        span.decompose()

                    for span in i.find_all("span", {'class': 'cl'}):
                        span.decompose()

                    for link in i.find_all("a", {'class': 'vp'}):
                        link.decompose()

                    target_textfile.write(i.get_text() + '\n')
                # for i in jehovahArticleSoupRaw.find_all('p'):
                #     for span in i.find_all("span", {'class': 'vl'}):
                #         span.decompose()

                #     for span in i.find_all("span", {'class': 'cl'}):
                #         span.decompose()

                #     for link in i.find_all("a", {'class': 'vp'}):
                #         link.decompose()

                #     for j in i.find_all('span', {'class': 'v'}):
                #         target_textfile.write(j.get_text() + '\n')
                target_textfile.close()
        except UnicodeDecodeError:
            print('UnicodeDecodeError occurred. Going on to next textfile')
        except IsADirectoryError:
            print('IsADirectoryError occurred. Going on to next textfile')
