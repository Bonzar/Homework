from json import dump

with open('text_7.txt', 'r', encoding='utf-8') as text7:
    firms = text7.readlines()
    resultList = [{}, {}]
    to_avr_profit =[]
    for firm in firms:
        nameFirm = firm.split()[0]
        revenue = int(firm.split()[2])
        cost = int(firm.split()[3])
        profit = revenue - cost
        resultList[0][nameFirm] = profit
        if profit >= 0:
            to_avr_profit.append(profit)
    resultList[1]['avrProfit'] = sum(to_avr_profit)/len(to_avr_profit)
    with open('text_77.json', 'w', encoding='utf-8') as json_text77:
        dump(resultList, json_text77, indent=4, ensure_ascii=False)
