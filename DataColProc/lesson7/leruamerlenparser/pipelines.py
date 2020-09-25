# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter

import scrapy
from pymongo import MongoClient
from scrapy.pipelines.images import ImagesPipeline
import hashlib
from scrapy.utils.python import to_bytes


def concatenate_params(item):
    if item['name_params']:
        item['dict_params'] = [{name: item['value_params'][num]} for num, name in enumerate(item['name_params'])]
        del item['value_params'], item['name_params']
    return item


class LeruamerlenparserPipeline:
    def __init__(self):
        client = MongoClient('localhost', 27017)
        self.mongo_base = client['HardwareStore']

    def process_item(self, item, spider):
        collection = self.mongo_base[spider.name]
        item = concatenate_params(item)
        collection.update({'url': item['url']}, {'$set': item}, upsert=True)
        return item


class LeruamerlenPhotoParserPipeline(ImagesPipeline):
    def get_media_requests(self, item, info):
        if item['images']:
            for img_link in item['images']:
                try:
                    # yield scrapy.Request(img_link)
                    yield scrapy.Request(img_link, meta=item)
                except Exception as e:
                    print(e)
        return item

    def file_path(self, request, response=None, info=None):
        folder_name = request.meta['url'].split('/')[-2]
        domen_name = request.meta['url'].split('/')[2]
        image_guid = hashlib.sha1(to_bytes(request.url)).hexdigest()
        return 'full/%s/%s/%s.jpg' % (domen_name, folder_name, image_guid)

    def item_completed(self, results, item, info):
        if results:
            item['images'] = [itm[1] for itm in results if itm[0]]
        return item
