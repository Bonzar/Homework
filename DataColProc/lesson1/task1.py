import requests

user = 'Bonzar'
link = f'https://api.github.com/users/{user}/repos'

user_repo_list = []
response = requests.get(link)

print(f"Repo's of user - {user}:")
for n, repo in enumerate(response.json()):
    user_repo_list.append(repo['name'])
    print(f"{n + 1}. {repo['name']}")

with open(f'{user}_repos.json', 'w') as ur:
    ur.write(f'{user_repo_list}')
