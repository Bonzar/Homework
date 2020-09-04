# Получение лучших исполнителей и треков для ВАС из Spotify

import requests
import json
from pprint import pprint


def take_user_tops(top_types):
    user_tops = {}
    for top_type in top_types:
        user_tops[top_type] = []
        main_link = f'https://api.spotify.com/v1/me/top/{top_type}'
        response = requests.get(main_link, headers=headers)
        for obj in response.json()['items']:
            user_tops[top_type].append(obj['name'])

    with open('task2_1_response.json', 'w') as task2_1_resp:
        json.dump(user_tops, task2_1_resp)

    with open('task2_1_response.json', 'r') as task2_1_resp:
        pprint(json.load(task2_1_resp))


headers = {
    'client_id': '8047c7c2fbc8454bba6e7b9e9a1882f0',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer BQCU1Ldph2D-dNAFRweA0hB9RZkdH_ONUppY4YMl1mADT4TtPJWd2u4hCUpymwF370jNMMdMgJ5XMMryk0BE-mfIxu6zRaZf5NMNTHYs2C5VKrFadzrEcMRb0_42YxjpT3Rjiit3o6AFw4dc7T5X5P3ucDMzpwpHvxLlDHZAqy04XaxZp0cdcV4YchR6w9hndshdPjffdHSwhpjqP-9Gp9Cxw12mQKPBm8AaomjVkPVddCoUQkNF7edplXuYaGmqYUhWJsE7xisX4KZyA10CfVyPsWp23uSvzM6zNA_P'
}

take_user_tops(['tracks', 'artists'])
