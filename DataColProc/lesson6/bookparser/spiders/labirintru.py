import scrapy
from scrapy.http import HtmlResponse
from bookparser.items import BookparserItem


class LabirintruSpider(scrapy.Spider):
    name = 'labirintru'
    allowed_domains = ['labirint.ru']
    start_urls = ['https://www.labirint.ru/search/комиксы/']

    def parse(self, response: HtmlResponse):
        book_urls = response.css("a.product-title-link::attr(href)").extract()
        for book_url in book_urls:
            yield response.follow(book_url, callback=self.book_parse)

        next_page = response.css("a.pagination-next__text::attr(href)").extract_first()
        if next_page:
            yield response.follow(next_page, callback=self.parse)

    def book_parse(self, response: HtmlResponse):
        name = response.xpath("//h1/text()").extract_first()
        url = response.url
        authors = response.xpath("//div[@class='authors']/a/text()").extract()
        main_price = response.xpath("//span[@class='buying-priceold-val-number']/text()").extract_first()
        sale_price = response.xpath("//span[@class='buying-pricenew-val-number']/text()").extract_first()
        rating = response.xpath("//div[@id='rate']/text()").extract_first()
        yield BookparserItem(name=name, url=url, authors=authors, main_price=main_price, sale_price=sale_price,
                             rating=rating)
