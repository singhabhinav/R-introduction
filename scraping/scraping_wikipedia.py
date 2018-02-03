# To make HTTP request
import requests

# Browser agent string
# Get your browser agent string from here https://udger.com/resources/online-parser
user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'

# URL to scrap
url = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"

headers = {'User-Agent': user_agent}

# Get URL content
page = requests.get(url, headers)

print(page.content)

from bs4 import BeautifulSoup
soup = BeautifulSoup(page.content, 'html.parser')

print(soup.prettify())

print(soup.title)

# Just for practice
# Get all hyperlinks in the page
all_links = soup.find_all("a")
print(all_links)
for link in all_links:
    print(link.get('href'))

# Get all tables
all_tables = soup.find_all('table')
print(all_tables)


# Select the right table in which data is there
right_table = soup.find('table', class_='wikitable sortable plainrowheaders')
print(right_table)


# Generate lists to store scraped data
A = [] # For Number
B = [] # For State/UT
C = [] # For Administrative capitals
D = [] # For Legislative capitals
E = [] # For Judiciary capitals
F = [] # For Year capital was established
G = [] # The Former capital

for row in right_table.findAll("tr"):
    cells = row.findAll('td')
    states = row.findAll('th') #To store second column data
    if len(cells) == 6: # Only extract table body not heading
        A.append(cells[0].find(text=True))
        B.append(states[0].find(text=True))
        C.append(cells[1].find(text=True))
        D.append(cells[2].find(text=True))
        E.append(cells[3].find(text=True))
        F.append(cells[4].find(text=True))
        G.append(cells[5].find(text=True))

import pandas as pd
df = pd.DataFrame(A,columns=['Number'])
df['State/UT'] = B
df['Admin_Capital'] = C
df['Legislative_Capital'] = D
df['Judiciary_Capital'] = E
df['Year_Capital'] = F
df['Former_Capital'] = G
print(df)
df.to_csv("capitals.csv", sep='\t', encoding='utf-8')
