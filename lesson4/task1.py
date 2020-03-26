import sys


def money_for_work():
    script_name, money_to_hour, hours, award = sys.argv
    return int(money_to_hour) * int(hours) + int(award)


print(money_for_work())
