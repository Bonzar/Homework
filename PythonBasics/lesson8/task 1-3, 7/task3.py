class IsNumber(Exception):
    def __init__(self, txt):
        self.txt = txt


def list_of_numbers():
    list_numbers = []
    while True:
        try:
            el = input('Enter an element of list: ')
            if el.title() == 'Stop':
                break
            elif el.isdigit():
                list_numbers.append(el)
            else:
                raise IsNumber('Not a number was entered!')
        except IsNumber as err:
            print(err)
    print(list_numbers)


list_of_numbers()
