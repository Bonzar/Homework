from pymongo import MongoClient

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter


class BookparserPipeline:
    def __init__(self):
        client = MongoClient('localhost', 27017)
        self.mongobase = client['books_GB_l6']

    def process_item(self, item, spider):
        collection = self.mongobase[spider.name]
        if spider.name == 'labirintru':
            book_dict = dict(item)
            main_price = book_dict['main_price']
            sale_price = book_dict['sale_price']
            rating = book_dict['rating']
            if rating:
                book_dict['rating'] = float(rating)
            if main_price:
                book_dict['main_price'] = int(main_price)
            if sale_price:
                book_dict['sale_price'] = int(sale_price)
            collection.update_one({'url': item['url']}, {'$set': book_dict}, upsert=True)
        elif spider.name == 'book24ru':
            main_price = item['main_price']
            sale_price = item['sale_price']
            rating = item['rating']
            if main_price:
                main_price = int(main_price[:-2].replace(' ', ''))
            if sale_price:
                sale_price = int(sale_price.replace(' ', ''))
            else:
                main_price = sale_price

            if rating:
                rating = float(rating.replace(',', '.'))

            book_dict = {'name': item['name'],
                         'url': item['url'],
                         'authors': item['authors'],
                         'main_price': main_price,
                         'sale_price': sale_price,
                         'rating': rating}

            collection.update_one({'url': item['url']}, {'$set': book_dict}, upsert=True)
        return book_dict
