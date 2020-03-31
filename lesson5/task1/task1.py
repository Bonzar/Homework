with open('new_file.txt', 'w+', encoding='utf-8') as new_file:
    print('Enter what you want to write to the file line by line, and send an empty string to finish:')
    while True:
        text = input()
        if text:
            print(text, file=new_file)
        else:
            break
    new_file.seek(0)
    print(f"Here's what's in the file now:\n\n{new_file.read()}", end='')
