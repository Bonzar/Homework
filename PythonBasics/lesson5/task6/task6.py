from json import dumps

with open('text_6.txt', 'r', encoding='utf-8') as text_6:
    dictSubject = {line.split(': ')[0].title(): line.split(': ')[1][:-1] for line in text_6.readlines()}
    for key, value in dictSubject.items():
        hours = 0
        for i in value.split():
            if i != '-':
                hours += int(i.split('(')[0])
        dictSubject[key] = hours
    print(dumps(dictSubject, indent=4, separators=('', ': ')))