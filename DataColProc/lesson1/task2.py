# Получение открытых плейлистов пльзователя из Spotify

import requests
import json
from pprint import pprint

user_id = '31umwnlhqygc7lqssyntrtjytxv4'
playlists_link = f'https://api.spotify.com/v1/users/{user_id}/playlists'
profile_link = f'https://api.spotify.com/v1/users/{user_id}'

headers = {
    'client_id': '8047c7c2fbc8454bba6e7b9e9a1882f0',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer BQCU1Ldph2D-dNAFRweA0hB9RZkdH_ONUppY4YMl1mADT4TtPJWd2u4hCUpymwF370jNMMdMgJ5XMMryk0BE-mfIxu6zRaZf5NMNTHYs2C5VKrFadzrEcMRb0_42YxjpT3Rjiit3o6AFw4dc7T5X5P3ucDMzpwpHvxLlDHZAqy04XaxZp0cdcV4YchR6w9hndshdPjffdHSwhpjqP-9Gp9Cxw12mQKPBm8AaomjVkPVddCoUQkNF7edplXuYaGmqYUhWJsE7xisX4KZyA10CfVyPsWp23uSvzM6zNA_P'
}
profile_response = requests.get(profile_link, headers=headers)
user_playlists = {"User": {"User_name": f"{profile_response.json()['display_name']}",
                      "url": f"https://open.spotify.com/user/{user_id}"},
             "Playlists": []}

response = requests.get(playlists_link, headers=headers)
for obj in response.json()['items']:
    user_playlists["Playlists"].append({"Playlist_name": f"{obj['name']}, url: {obj['external_urls']['spotify']}"})

with open('task2_response.json', 'w') as task2_resp:
    json.dump(user_playlists, task2_resp)

with open('task2_response.json', 'r') as task2_resp:
    pprint(json.load(task2_resp))