from pymongo import MongoClient


class InstaparserPipeline:
    def __init__(self):
        mongo_client = MongoClient('localhost', 27017)
        self.mongo_data_base = mongo_client['instargram_relations']

    def process_item(self, item, spider):
        if item['data_type'] == 'follow':
            self.save_follow(item)
        elif item['data_type'] == 'subscribe':
            self.save_subscribe(item)
        return item

    def save_follow(self, item):
        collection = self.mongo_data_base['follows']
        item.pop('data_type')
        collection.update({'follower_owner_id': item['follower_owner_id'], 'follower_id': item['follower_id']},
                          {'$set': item},
                          upsert=True)
        return item

    def save_subscribe(self, item):
        collection = self.mongo_data_base['subscribes']
        item.pop('data_type')
        collection.update({'subscriber_owner_id': item['subscriber_owner_id'], 'subscriber_id': item['subscriber_id']},
                          {'$set': item},
                          upsert=True)
        return item
