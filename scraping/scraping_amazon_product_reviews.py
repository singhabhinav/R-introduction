#!/usr/bin/env python
# coding: utf-8

# In[1]:


from lxml import html

# To make HTTP request
import requests
import pandas as pd

reviews_df = pd.DataFrame()

# Browser agent string
# Get your browser agent string from here https://udger.com/resources/online-parser
user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'

amazon_url = 'https://www.amazon.in/Test-Exclusive-558/product-reviews/B077PWJRFH/?pageNumber=2'

headers = {'User-Agent': user_agent}
page = requests.get(amazon_url, headers = headers)
parser = html.fromstring(page.content)

xpath_reviews = '//div[@data-hook="review"]'
reviews = parser.xpath(xpath_reviews)

xpath_rating  = './/i[@data-hook="review-star-rating"]//text()'
xpath_title   = './/a[@data-hook="review-title"]//text()'
#xpath_author  = './/a[@data-hook="review-author"]//text()'
xpath_author  = './/span[@class="a-profile-name"]//text()'
xpath_date    = './/span[@data-hook="review-date"]//text()'
xpath_body    = './/span[@data-hook="review-body"]//text()'
xpath_helpful = './/span[@data-hook="helpful-vote-statement"]//text()'

for review in reviews:
    rating  = review.xpath(xpath_rating)
    title   = review.xpath(xpath_title)
    author  = review.xpath(xpath_author)
    date    = review.xpath(xpath_date)
    body    = review.xpath(xpath_body)
    helpful = review.xpath(xpath_helpful)

    review_dict = {'rating': rating,
                   'title': title,
                   'author': author,
                   'date': date,
                   'body': body,
                   'helpful': helpful}
    reviews_df = reviews_df.append(review_dict, ignore_index=True)

reviews_df.to_csv("amazon_product_reviews.csv", sep='\t', encoding='utf-8')
print(reviews_df)


# In[ ]:




