with open('task2.txt', 'r', encoding='utf-8') as txt_task2:
    for ind, text_line in enumerate(txt_task2.readlines()):
        print(f'In {ind+1} line - {len(text_line.split())} words')
    print('Total lines:', ind+1)
