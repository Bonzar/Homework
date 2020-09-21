from selenium.webdriver import Safari
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from pymongo import MongoClient
from mailru_login import get_login, get_password
import time
import json

client = MongoClient('127.0.0.1', 27017)


def mailru_collector():
    driver = Safari()
    driver.maximize_window()
    db = client['Sends_from_mailru']
    sends_in_db = db.sends_in_db

    driver.get('https://mail.ru')

    elem = driver.find_element_by_id('mailbox:login-input')
    elem.send_keys(get_login())
    elem.submit()

    elem = WebDriverWait(driver, 10).until(
        EC.visibility_of(driver.find_element_by_id('mailbox:password-input'))
    )
    elem.send_keys(get_password())
    elem.submit()

    WebDriverWait(driver, 10).until(EC.title_contains('- Почта Mail.ru'))

    sends_block = driver.find_element_by_xpath("//div[@class='dataset__items']")
    sends = set()
    while True:
        len_of_sends_list = len(sends)
        list_sends = sends_block.find_elements_by_xpath(".//a[@href]")
        for send in list_sends:
            sends.add(send.get_attribute('href'))
        if len(sends) == len_of_sends_list:
            break

        # Можно выполнять скролл без записи в переменную? И для чего его можно записывать?
        var = list_sends[-1].location_once_scrolled_into_view

        # Без задержки не находил элемент для пролистывания, не выявил причину, и не смог реализовать через
        # WebdriverWait и EC. Есть ли вариант с их использованием?
        time.sleep(1)

    while sends:
        send_dict = {}
        send_url = sends.pop()
        driver.get(send_url)

        # Долго искал и не смог найти условие для задержки в EC, чтоб дала прогрузиться письму.
        # Есть ли таковая, или другая работяющая в этом случае?
        time.sleep(1)

        text_send = driver.find_element_by_xpath("//div[contains(@class, 'letter-body')]").text
        title_send = driver.find_element_by_tag_name('h2').text
        from_send = driver.find_element_by_class_name('letter-contact').text
        date_send = driver.find_element_by_class_name('letter__date').text

        send_dict['text'] = text_send
        send_dict['title'] = title_send
        send_dict['from'] = from_send
        send_dict['date'] = date_send
        send_dict['url'] = send_url

        sends_in_db.update_one({'url': send_url}, {'$set': send_dict}, upsert=True)

    driver.close()


def mvideo_hits_collector():
    driver = Safari()
    driver.maximize_window()

    db = client['Goods_from_hits_mvideo']
    goods_in_db = db.goods_in_db

    driver.get('https://www.mvideo.ru')

    gallery_titles = driver.find_elements_by_xpath("//div[@class='gallery-title-wrapper']")
    for gal_title in gallery_titles:
        if 'Хиты продаж' in gal_title.text:
            hits_block = gal_title.find_element_by_xpath("./ancestor::div[@class='section']")
            next_button = hits_block.find_element_by_xpath(".//a[contains(@class, 'next-btn')]")

            while True:
                next_button.click()
                time.sleep(2)
                if 'disable' in next_button.get_attribute('class'):
                    break
                # Можно ли передать EC элемент в котором искать? В данном случае нужно передать hits_block, чтобы
                # искать в нём, тк таких кнопок на сайте нет, нельзя с уверенностью найти определенную и проверять
                # её кликабельность. Или если есть способ, то как?

                # WebDriverWait(driver, 5).until(EC.element_to_be_clickable(
                #     (By.XPATH, ".//a[contains(@class, 'next-btn')]")))

            goods_list_html = hits_block.find_elements_by_xpath(".//li//h4/a")

            for good in goods_list_html:
                good_dict = {}

                good_url = good.get_attribute('href')
                good_desc = json.loads(good.get_attribute('data-product-info'))
                good_name = good_desc['productName']
                good_price = float(good_desc['productPriceLocal'])
                good_category = good_desc['productCategoryName']

                good_dict['url'] = good_url
                good_dict['name'] = good_name
                good_dict['price'] = good_price
                good_dict['category'] = good_category

                goods_in_db.update_one({'url': good_url}, {'$set': good_dict}, upsert=True)

    driver.close()
