import requests
import pandas as pd
from bs4 import BeautifulSoup as bs


def get_vacancy_from_sj(vacancy_name):
    vacancies_list = []

    vacancy_input = vacancy_name

    main_link = 'https://www.superjob.ru'

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 '
                      'YaBrowser/20.9.0.416 (beta) Yowser/2.5 Safari/537.36'}

    params = {'keywords': vacancy_input,
              'noGeo': '1'}

    html = requests.get(main_link + '/vacancy/search/', headers=headers, params=params)

    parsed_html = bs(html.text, 'html.parser')

    pager_block = parsed_html.find('a', {'rel': 'next'})
    if pager_block:
        max_page = parsed_html.find('a', {
            'class': 'icMQ_ _1_Cht _3ze9n f-test-button-dalshe f-test-link-Dalshe'}).previous_sibling.getText()
    else:
        max_page = 1

    for page in range(int(max_page)):
        params['page'] = page
        html = requests.get(main_link + '/vacancy/search/', headers=headers, params=params)

        parsed_html = bs(html.text, 'html.parser')
        html_vacancies_block = parsed_html.find('div', {'class': '_1ID8B'})
        html_vacancies_list = html_vacancies_block.find_all('div', {'class': 'jNMYr GPKTZ _1tH7S'})

        for html_vacancy in html_vacancies_list:
            salary_max, salary_min = None, None

            vacancy_name_url = html_vacancy.find('div', {'class': '_3mfro PlM3e _2JVkc _3LJqf'})
            vacancy_name = vacancy_name_url.getText()
            vacancy_url = main_link + vacancy_name_url.findChildren()[0]['href']

            vacancy_salary = html_vacancy.find('span', {'class': '_3mfro _2Wp8I PlM3e _2JVkc _2VHxz'})
            vacancy_salary_list = vacancy_salary.contents
            if len(vacancy_salary_list) != 1:
                if vacancy_salary.find_next('span', {'class': '_3mfro PlM3e _2JVkc _2VHxz'}).getText() == 'день':
                    salary_multiplier = 30
                elif vacancy_salary.find_next('span', {'class': '_3mfro PlM3e _2JVkc _2VHxz'}).getText() == 'час':
                    salary_multiplier = 240
                else:
                    salary_multiplier = 1

                if vacancy_salary_list[0] == 'от':
                    salary_min = int(vacancy_salary_list[-1][:-4].replace('\xa0', '')) * salary_multiplier
                    currency = vacancy_salary_list[-1][-4:-1]
                elif vacancy_salary_list[0] == 'до':
                    salary_max = int(vacancy_salary_list[-1][:-4].replace('\xa0', '')) * salary_multiplier
                    currency = vacancy_salary_list[-1][-4:-1]
                elif '—' in vacancy_salary_list[1]:
                    salary_min = int(vacancy_salary_list[0].replace('\xa0', '')) * salary_multiplier
                    salary_max = int(vacancy_salary_list[2].replace('\xa0', '')) * salary_multiplier
                    currency = vacancy_salary_list[-1][:-1]
                else:
                    salary_min = int(vacancy_salary_list[0].replace('\xa0', '')) * salary_multiplier
                    salary_max = salary_min
            else:
                salary_min = None
                salary_max = None
                currency = None

            vacancies_list.append([vacancy_name, salary_min, salary_max, currency, vacancy_url, main_link])

    return pd.DataFrame(vacancies_list, columns=['name', 'min_salary', 'max_salary', 'currency', 'url', 'source'])
