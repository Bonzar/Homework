import requests
import pandas as pd
from bs4 import BeautifulSoup as bs


def get_vacancy_from_hh(vacancy_name):
    vacancies_list = []

    vacancy_input = vacancy_name

    main_link = 'https://hh.ru'

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 '
                      'YaBrowser/20.9.0.416 (beta) Yowser/2.5 Safari/537.36'}

    params = {'clusters': 'true',
              'search_field': 'name',
              'enable_snippets': 'true',
              'salary': '',
              'st': 'searchVacancy',
              'text': vacancy_input}

    html = requests.get(main_link + '/search/vacancy', headers=headers, params=params)
    parsed_html = bs(html.text, 'html.parser')

    pager_block = parsed_html.find('div', {'data-qa': 'pager-block'})
    if pager_block:
        if pager_block.find(text='''
                …
                '''):
            max_page = pager_block.find('a', {
                'class': 'bloko-button HH-Pager-Controls-Next HH-Pager-Control'
            }).previous_sibling.findChildren()[1]['data-page']
        else:
            max_page = pager_block.find_all('a', {'class': 'bloko-button HH-Pager-Control'})[-1]['data-page']
    else:
        max_page = 0

    for page in range(int(max_page) + 1):
        params['page'] = page
        html = requests.get(main_link + '/search/vacancy', headers=headers, params=params)
        parsed_html = bs(html.text, 'html.parser')
        html_vacancies_block = parsed_html.find('div', {'class': 'vacancy-serp'})
        html_vacancies_list = html_vacancies_block.find_all('div', {'class': 'vacancy-serp-item'})

        for html_vacancy in html_vacancies_list:
            salary_max, salary_min = None, None

            vacancy_name_url = html_vacancy.find('a', {'class': 'bloko-link HH-LinkModifier'})
            vacancy_name = vacancy_name_url.getText()
            vacancy_url = vacancy_name_url['href']
            vacancy_salary = html_vacancy.find('div', {'class': 'vacancy-serp-item__sidebar'}).getText()
            vacancy_salary_prepared_list = vacancy_salary.replace('\xa0', '').split()
            if vacancy_salary_prepared_list:
                if vacancy_salary_prepared_list[0] == 'от':
                    salary_min = vacancy_salary_prepared_list[1]
                elif vacancy_salary_prepared_list[0] == 'до':
                    salary_max = vacancy_salary_prepared_list[1]
                else:
                    vacancy_salary_prepared_MinMax = vacancy_salary_prepared_list[0].split('-')
                    salary_min = vacancy_salary_prepared_MinMax[0]
                    salary_max = vacancy_salary_prepared_MinMax[1]
                currency = vacancy_salary_prepared_list[-1][:-1]
            else:
                salary_min = None
                salary_max = None
                currency = None

            vacancies_list.append([vacancy_name, salary_min, salary_max, currency, vacancy_url, main_link])

    return pd.DataFrame(vacancies_list, columns=['name', 'min_salary', 'max_salary', 'currency', 'url', 'source'])
