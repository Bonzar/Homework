import scrapy


class InstaparserItem(scrapy.Item):

    follower_username = scrapy.Field()
    follower_fullname = scrapy.Field()
    follower_id = scrapy.Field()
    follower_profile_pic_url = scrapy.Field()
    follower_data = scrapy.Field()
    follower_owner_id = scrapy.Field()

    subscriber_username = scrapy.Field()
    subscriber_fullname = scrapy.Field()
    subscriber_id = scrapy.Field()
    subscriber_profile_pic_url = scrapy.Field()
    subscriber_data = scrapy.Field()
    subscriber_owner_id = scrapy.Field()

    data_type = scrapy.Field()
    _id = scrapy.Field()
