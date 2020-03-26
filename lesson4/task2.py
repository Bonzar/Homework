list_of_numbers = [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]
new_list = [list_of_numbers[i] for i in range(1, len(list_of_numbers)) if list_of_numbers[i] > list_of_numbers[i - 1]]
print(new_list)
