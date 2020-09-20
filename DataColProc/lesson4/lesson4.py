import requests
from lxml import html
from pprint import pprint


def get_mailru_news():
    main_link = 'https://news.mail.ru'

    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/84.0.4147.86 YaBrowser/20.8.0.893 Yowser/2.5 Yptp/1.23 Safari/537.36 '}

    mr_response = requests.get(main_link, headers=headers)
    mr_dom = html.fromstring(mr_response.text)
    mr_news_urls = mr_dom.xpath(
        "//div[contains(@class, 'daynews__item')]/a/@href | //ul[@name='clb20268353']/li/a/@href")

    mr_news_list = []

    for mr_news_url in mr_news_urls:
        mr_news_dict = {}
        news_mr_response = requests.get(mr_news_url, headers=headers)
        news_mr_dom = html.fromstring(news_mr_response.text)

        mr_news_name = news_mr_dom.xpath("//h1/text()")
        mr_news_source = news_mr_dom.xpath("//span[@class='breadcrumbs__item'][2]/span/a/span/text()")
        mr_news_date = news_mr_dom.xpath("//span[@class='breadcrumbs__item'][1]/span/span/@datetime ")

        mr_news_dict['name'] = mr_news_name[0]
        mr_news_dict['source'] = mr_news_source[0]
        mr_news_dict['url'] = mr_news_url
        mr_news_dict['date'] = mr_news_date[0]

        mr_news_list.append(mr_news_dict)

    return mr_news_list


def get_yandex_news():
    main_link = 'https://yandex.ru/news'

    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/84.0.4147.86 YaBrowser/20.8.0.893 Yowser/2.5 Yptp/1.23 Safari/537.36 '}

    ya_response = requests.get(main_link, headers=headers)
    ya_dom = html.fromstring(ya_response.text)

    ya_news_list = []

    ya_news_block = ya_dom.xpath("//div[contains(@class, 'news-top-stories')]/div[contains(@class, 'mg-grid__col')]")

    for ya_news in ya_news_block:
        ya_news_dict = {}
        ya_news_url = ya_news.xpath(".//a[@class='news-card__link']/@href")

        # get name of news
        ya_news_url_response = requests.get(ya_news_url[0], headers=headers)
        ya_news_url_dom = html.fromstring(ya_news_url_response.text)
        ya_news_name = ya_news_url_dom.xpath("//h1/text()")

        ya_news_source = ya_news.xpath(".//span[@class='mg-card-source__source']/a/text()")
        ya_news_date = ya_news.xpath(".//span[@class='mg-card-source__time']/text()")

        ya_news_dict['name'] = ya_news_name[0]
        ya_news_dict['source'] = ya_news_source[0]
        ya_news_dict['url'] = ya_news_url[0]
        ya_news_dict['date'] = ya_news_date[0]

        ya_news_list.append(ya_news_dict)

    return ya_news_list


def get_lenta_news():
    main_link = 'https://lenta.ru'

    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/84.0.4147.86 YaBrowser/20.8.0.893 Yowser/2.5 Yptp/1.23 Safari/537.36 '}

    lenta_response = requests.get(main_link, headers=headers)
    lenta_dom = html.fromstring(lenta_response.text)
    lenta_news_block = lenta_dom.xpath("//section[contains(@class,'b-top7-for-main')]//div[contains(@class,'item')]")

    lenta_news_list = []

    first_news = True
    for lenta_news in lenta_news_block:
        lenta_news_dict = {}
        if first_news:
            first_news = False
            lenta_news_url = lenta_news.xpath(".//h2/a/@href")[0]
            lenta_news_date = lenta_news.xpath(".//h2/a/time/@datetime")

        else:
            lenta_news_url = lenta_news.xpath("./a/@href")[0]
            lenta_news_date = lenta_news.xpath("./a/time/@datetime")

        # обработка случаев когда указана полная ссылка
        if lenta_news_url[0] == '/':
            lenta_news_url = main_link + lenta_news_url

        # получение названия новости
        lenta_news_url_response = requests.get(lenta_news_url, headers=headers)
        lenta_news_url_dom = html.fromstring(lenta_news_url_response.text)
        lenta_news_name = lenta_news_url_dom.xpath("//h1/text()")[0].replace('\xa0', ' ')

        lenta_news_dict['name'] = lenta_news_name
        lenta_news_dict['source'] = main_link
        lenta_news_dict['url'] = lenta_news_url
        lenta_news_dict['date'] = lenta_news_date[0]

        lenta_news_list.append(lenta_news_dict)

    return lenta_news_list


all_news = get_lenta_news() + get_mailru_news() + get_yandex_news()
pprint(all_news)
