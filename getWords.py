import requests
from bs4 import BeautifulSoup
import re

url = "https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Korean_5800"
response = requests.get(url)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')

    only_korean = re.compile(r'^[가-힣]+$')

    words = []
    for a_tag in soup.find_all('a', title=True):
        if only_korean.match(a_tag.text) and a_tag['title'] == a_tag.text:
            words.append(a_tag.text)

    print(len(words))
    
    with open("words.txt", "w", encoding="euc-kr") as f: # utf-8은 오토핫키로 읽는 법을 모르겠음
        f.write("\n".join(words) + "\n")

else:
    print(f"fail, status code: {response.status_code}")
