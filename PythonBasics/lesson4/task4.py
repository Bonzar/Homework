from random import randrange

start_list = [randrange(50) for i in range(100)]
new_list = [number for number in start_list if start_list.count(number) == 1]
print(new_list)
