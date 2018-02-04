'''
Install pycorenlp first
pip install pycorenlp
'''

import csv
import sys
from pycorenlp import StanfordCoreNLP
import re
import string

nlp = StanfordCoreNLP('http://localhost:9000')


def get_sentiment(weighted_sentiment):
    if weighted_sentiment <= 0.0:
        return "NOT_UNDERSTOOD"
    if weighted_sentiment < 1.6:
      return "NEGATIVE"
    if weighted_sentiment <= 2.0:
      return "NEUTRAL"
    if weighted_sentiment < 5.0:
      return "POSITIVE"
    return "NOT_UNDERSTOOD"

def transform_tweet(line):
    line = re.compile('\<U\+([0-9a-fA-F]+)\>').sub('', line)
    line = re.compile('<ed>').sub('', line)
    line = re.compile('#\w+ ').sub('', line)
    line = re.compile('RT @\w+: ').sub('', line)
    line = re.compile('via @\w+: ').sub('', line)
    line = re.compile('@\w+').sub('', line)
    line = re.compile('http\S+').sub('', line)
    line = re.compile('[^0-9a-zA-Z]+').sub(' ', line)
    #line = re.compile('[%s]' % re.escape(string.punctuation)).sub(' ', line)
    return line


def write_sentiment_data(filename, data=None, fieldnames=None, write_header=False):
    with open(filename, 'a', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        if write_header:
            writer.writeheader()
        else:
            writer.writerow(data)


with open('tweets.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)


    sentiment_data_fieldnames = ['id_str','from_user','text','sentiment','created_at','time','geo_coordinates','user_lang','in_reply_to_user_id_str','in_reply_to_screen_name','from_user_id_str','in_reply_to_status_id_str','source','profile_image_url','user_followers_count','user_friends_count','user_location','status_url','entities_str']
    write_sentiment_data(filename="sentiment_data.csv", fieldnames=sentiment_data_fieldnames, write_header=True)
    for row in reader:
        sum_of_scores = 0
        text_length = 0
        res = nlp.annotate(transform_tweet(row['text']), properties={
            'annotators': 'sentiment',
            'outputFormat': 'json',
            'timeout': 10000,
        })

        for s in res["sentences"]:
            text_length = 0
            for token in s['tokens']:
                text_length += len(token['word'])
            sum_of_scores = sum_of_scores + int(s['sentimentValue']) * text_length
            sentence = " ".join([t["word"] for t in s["tokens"]])
            text_length += len(s)

        try:
            weighted_sentiment = sum_of_scores/text_length
        except:
            weighted_sentiment = 0
        data = {
            'id_str': row['id_str'],
            'from_user': row['from_user'],
            'text': row['text'],
            'sentiment': get_sentiment(weighted_sentiment),
            'created_at': row['created_at'],
            'time': row['time'],
            'geo_coordinates': row['geo_coordinates'],
            'user_lang': row['user_lang'],
            'in_reply_to_user_id_str': row['in_reply_to_user_id_str'],
            'in_reply_to_screen_name': row['in_reply_to_screen_name'],
            'from_user_id_str': row['from_user_id_str'],
            'source': row['source'],
            'profile_image_url': row['profile_image_url'],
            'user_followers_count': row['user_followers_count'],
            'user_friends_count': row['user_friends_count'],
            'user_location': row['user_location'].lower(),
            'status_url': row['status_url'],
            'entities_str': row['entities_str'],
        }
        write_sentiment_data(filename="sentiment_data.csv", data=data, fieldnames=sentiment_data_fieldnames)
        print("%s %s %s %s" % (sentence, text_length, sum_of_scores, weighted_sentiment))
