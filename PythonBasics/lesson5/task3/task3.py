from functools import reduce

with open('text_3.txt', 'r', encoding='utf-8') as txt_text_3:
    workers = {line.split()[0]: float(line.split()[1]) for line in txt_text_3.readlines()}
    bed_workers = [surname for surname in workers.keys() if workers[surname] <= 20000]
    print(bed_workers)
    avg_income = reduce(lambda a, b: a + b, workers.values()) / len(workers.values())
    print(f'Average income of employee - {avg_income}')
