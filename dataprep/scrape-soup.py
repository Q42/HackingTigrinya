# -*- coding: utf-8 -*-
import requests, bs4

test_url = 'https://wol.jw.org/en/wol/d/r1/lp-e/1102008121'

res = requests.get(test_url)
res.raise_for_status()
jehovahSoup = bs4.BeautifulSoup(res.text, features="html.parser")

jehovahArticleSoupRaw = jehovahSoup.article

with open("bla.txt", "w+") as test_file:
    for i in jehovahArticleSoupRaw.find_all('p'):
        test_file.write(i.get_text() + '\n')
    test_file.close()
