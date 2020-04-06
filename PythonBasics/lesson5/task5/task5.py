from random import randrange

listNumbers = [randrange(20) for i in range(15)]
with open('FileWithNumbers.txt', '+w', encoding='utf-8') as FileNumbers:
    for number in listNumbers:
        print(number, end=' ', file=FileNumbers)
    FileNumbers.seek(0)
    listNumbersInFile = FileNumbers.readline()
    result = sum(map(int, listNumbersInFile.split()))
    print(f'The sum of the numbers: {listNumbersInFile} = {result}')
