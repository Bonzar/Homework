import scrapy
from scrapy.http import HtmlResponse
from leruamerlenparser.items import LeruamerlenparserItem
from scrapy.loader import ItemLoader


class LeroymerlinruSpider(scrapy.Spider):
    name = 'leroymerlinru'
    allowed_domains = ['leroymerlin.ru']

    def __init__(self, params):
        self.start_urls = [f"http://{params['sity']}.leroymerlin.ru/search/?q={params['search']}"]

    def parse(self, response:HtmlResponse):
        products_name_tags = response.xpath("//product-card//a[@slot='name']/@href").extract()
        for product in products_name_tags:
            yield response.follow(product, callback=self.product_parse)
        next_page = response.xpath("//div[@class='next-paginator-button-wrapper']/a/@href").extract_first()
        if next_page:
            yield response.follow(next_page, callback=self.parse)

    def product_parse(self, response:HtmlResponse):
        loader = ItemLoader(item=LeruamerlenparserItem(), response=response)

        loader.add_xpath("name", "//h1/text()")
        loader.add_xpath("price", "//span[@slot='price']/text()")
        loader.add_value("url", response.url)
        loader.add_xpath("images", "//uc-pdp-media-carousel//img[@itemprop='image']/@src")
        loader.add_xpath("name_params", "//dt/text()")
        loader.add_xpath("value_params", "//dd/text()")

        yield loader.load_item()
