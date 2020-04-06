from functools import reduce

list_of_numbers = [i for i in range(100, 1001) if i % 2 == 0]
full_number = reduce(lambda a, b: a * b, list_of_numbers)
print(full_number)
print(f'{len(str(full_number))} цифр - interesting :)')
