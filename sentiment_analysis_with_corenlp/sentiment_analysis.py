'''
Install pycorenlp first
pip install pycorenlp
'''

import csv
from pycorenlp import StanfordCoreNLP

nlp = StanfordCoreNLP('http://localhost:9000')


def write_sentiment_data(filename, data=None, fieldnames=None, write_header=False):
    print(filename)
    print(data)
    with open(filename, 'a', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        if write_header:
            print("i am if")
            writer.writeheader()
        else:
            print("i am in else")
            writer.writerow(data)


with open('climate_change.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    sentiment_data_fieldnames = ['id_str', 'from_user', 'sentence', 'sentiment_value', 'sentiment', 'created_at', 'user_location']
    write_sentiment_data(filename="sentiment_data.csv", fieldnames=sentiment_data_fieldnames, write_header=True)
    for row in reader:
        res = nlp.annotate(row['text'], properties={
            'annotators': 'sentiment',
            'outputFormat': 'json',
            'timeout': 10000,
        })

        for s in res["sentences"]:
            data = {
                'id_str': row['id_str'],
                'from_user': row['from_user'],
                'sentence': " ".join([t["word"] for t in s["tokens"]]),
                'sentiment_value': s['sentimentValue'],
                'sentiment': s['sentiment'],
                'created_at': row['created_at'],
                'user_location': row['user_location']
            }
            write_sentiment_data(filename="sentiment_data.csv", data=data, fieldnames=sentiment_data_fieldnames)
