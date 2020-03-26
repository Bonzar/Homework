def user(name, surname, year, city, email, phone):
    print(f'{name} {surname}, {year} year of birth, from {city}, email: {email}, phone: {phone}')


user(name=input('name: '), surname=input('surname: '), year=input('year: '), city=input('city: '),
     email=input('email: '), phone=input('phone: '))
