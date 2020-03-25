def my_func(num_1, num_2, num_3):
    list_of_numbs = [num_3, num_2, num_1]
    list_of_numbs.remove(min(list_of_numbs))
    result = sum(list_of_numbs)
    print(result)


my_func(int(input('Enter a first number: ')), int(input('Enter a second number: ')),
        int(input('Enter a three number: ')))
