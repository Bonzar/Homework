from vacancy import get_vacancy_from_hh
from vacancy_sj import get_vacancy_from_sj
import pandas as pd

input_vacancy_name = input('Введите желаемую должность: ')
vacancy_table_hh = get_vacancy_from_hh(input_vacancy_name)
vacancy_table_sj = get_vacancy_from_sj(input_vacancy_name)

vacancies_table = pd.concat([vacancy_table_hh, vacancy_table_sj], axis=0, ignore_index=True)
print()
