from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

my_url = "https://viterbi.usc.edu/calendar/"

uClient = uReq(my_url)
page_html = uClient.read()
uClient.close()

page_soup = soup(page_html, "html.parser")

date = page_soup.find('div', id='events')
print(date.h2.string + "\n")


# stats = page_soup.find_all('div', class="event_stats")
# print(stats)

i = 0

eventList = page_soup.find('div', id='events').ul
eventStats = page_soup.find_all("div", class_="event_stats")
#
p_list = eventList.find_all('p')
# for p in p_list:
#     print(p)


for event in eventList:
    print("NewItem:")
    print("Title: " + event.h3.a.string)
    data = eventStats[i].find_all('p')
    for string_data in data:
        print(string_data.string)
    i+1
    print(p_list[5].a.string)
    print(p_list[6].string)
    print("\n")