"""
setup:
navigeren door bible directories (books, chapters): engels en tigrinya in aparte py's
boek nummer (BoN) onthouden
    1-66
bestand nummer (BeN) onthouden
    lijst van bestanden in dir maken
bestand in <root taaldirectory>/structured opslaan als <BoN><BeN>.html

"""

"""
NB: to be executed using python3, not python2
"""

import os
import sys
import shutil

# print help(os)

language = sys.argv[1]

dest_path = os.path.join(os.getcwd(), "wget-scraped/wol.jw.org/{0}/structured_data_{0}".format(language))

if language == 'en':
    # change dir to english root
    os.chdir('wget-scraped/wol.jw.org/en/wol') #NB: change this to main english directory
    # change dir to bible texts
    os.chdir('b/r1/lp-e/nwt/E/2013')
    main_language_dir = os.getcwd()
    # navigate through books
    for book in os.listdir(main_language_dir):
        if os.path.isdir(book):
            os.chdir(book)
            # navigate through chapters
            for chapter in os.listdir(os.getcwd()):
                # print(chapter)
                # --> change name of chapter files and save to root dir

                chapter_nr = "{:02}".format(int(chapter))
                book_nr = "{:02}".format(int(book))
                if not os.path.exists(dest_path):
                    os.makedirs(dest_path)
                shutil.copy(os.path.join(os.getcwd(), chapter), os.path.join(dest_path, book_nr+chapter_nr))
                # os.rename(os.path.join(os.getcwd(), chapter), os.path.join(dest_path, book_nr+chapter_nr)) # os.rename deletes old files
            os.chdir('../')

elif language == 'ti':
    # change dir to tigrinya root
    os.chdir('wget-scraped/wol.jw.org/ti/wol') #NB: change this to main tigrinya directory

    # change dir to bible texts
    os.chdir('b/r119/lp-ti/nwt/TI/2015')
    main_language_dir = os.getcwd()
    # navigate through books
    for book in os.listdir(main_language_dir):
        if os.path.isdir(book):
            os.chdir(book)
            # navigate through chapters
            for chapter in os.listdir(os.getcwd()):
                # print(chapter)
                # --> change name of chapter files and save to root dir

                chapter_nr = "{:02}".format(int(chapter))
                book_nr = "{:02}".format(int(book))
                if not os.path.exists(dest_path):
                    os.makedirs(dest_path)
                shutil.copy(os.path.join(os.getcwd(), chapter), os.path.join(dest_path, book_nr+chapter_nr))
                # os.rename(os.path.join(os.getcwd(), chapter), os.path.join(dest_path, book_nr+chapter_nr)) # os.rename deletes old files
            os.chdir('../')

else:
    print("Please use supported languages: 'en'; 'ti'.")
