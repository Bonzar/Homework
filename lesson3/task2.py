def user(name, surname, year, city, email, phone):
    print(f'{name} {surname}, {year} year of birth, from {city}, email: {email}, phone: {phone}')


user(input('name: '), input('surname: '), input('year: '), input('city: '), input('email: '), input('phone: '))
