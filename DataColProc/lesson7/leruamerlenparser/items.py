# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html
import scrapy
from scrapy.loader.processors import TakeFirst, MapCompose


def converting_value_params(value_params):
    if value_params:
        for to_replace in ['\n                ', '\n            ', '    ']:
            value_params = value_params.replace(to_replace, '')
        if value_params.isdigit():
            return int(value_params)
        else:
            try:
                return float(value_params)
            except Exception:
                return value_params


class LeruamerlenparserItem(scrapy.Item):
    name = scrapy.Field(output_processor=TakeFirst())
    price = scrapy.Field(output_processor=TakeFirst())
    url = scrapy.Field(output_processor=TakeFirst())
    images = scrapy.Field()
    name_params = scrapy.Field()
    value_params = scrapy.Field(input_processor=MapCompose(converting_value_params))
    dict_params = scrapy.Field()
    _id = scrapy.Field()
