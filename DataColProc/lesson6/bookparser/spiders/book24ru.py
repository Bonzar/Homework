import scrapy
from scrapy.http import HtmlResponse
from bookparser.items import BookparserItem


class Book24ruSpider(scrapy.Spider):
    name = 'book24ru'
    allowed_domains = ['book24.ru']
    start_urls = ['https://book24.ru/search/?q=комиксы']

    def parse(self, response: HtmlResponse):
        book_urls = response.xpath("//div[@class='book__title ']//a/@href").extract()
        for book_url in book_urls:
            yield response.follow(book_url, callback=self.book_parse)
        next_page = response.xpath("//a[contains(@class, catalog-pagination__item)][.='Далее']/@href").extract_first()
        if next_page:
            yield response.follow(next_page, callback=self.parse)

    def book_parse(self, response: HtmlResponse):
        name = response.xpath("//h1/text()").extract_first()
        url = response.url
        authors = response.xpath("//span[.='Автор:']/following-sibling::span//a/text()").extract()
        rating = response.xpath("//span[@class='rating__rate-value']/text()").extract_first()
        main_price = response.xpath("//div[@class='item-actions__price-old']/text()").extract_first()
        sale_price = response.xpath("//div[@class='item-actions__price']/b/text()").extract_first()

        yield BookparserItem(name=name, url=url, authors=authors, main_price=main_price, sale_price=sale_price,
                             rating=rating)
