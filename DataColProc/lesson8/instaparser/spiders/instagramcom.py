import scrapy
from scrapy.http import HtmlResponse
from instaparser.items import InstaparserItem
import re
import json
from urllib.parse import urlencode
from copy import deepcopy
from InstaLogin import get_insta_login, get_insta_password


class InstagramcomSpider(scrapy.Spider):
    name = 'instagramcom'
    allowed_domains = ['instagram.com']
    start_urls = ['https://www.instagram.com/']
    our_inst_login = get_insta_login()
    our_inst_pwd = get_insta_password()
    inst_login_link = 'https://www.instagram.com/accounts/login/ajax/'
    list_of_parse_users_nickname = ['bonzarrr']

    graphql_url = '/graphql/query/?'
    query_follower_hash = 'c76146de99bb02f6415203be841dd25a'
    query_subscriber_hash = 'd04b0a864b4b54837c0d870b0e77e076'

    def parse(self, response: HtmlResponse):
        csrf_token = self.fetch_csrf_token(response.text)
        yield scrapy.FormRequest(
            self.inst_login_link,
            method='POST',
            callback=self.our_user_parse,
            formdata={'username': self.our_inst_login, 'enc_password': self.our_inst_pwd},
            headers={'X-CSRFToken': csrf_token}
        )

    def our_user_parse(self, response: HtmlResponse):
        html_body_json = json.loads(response.text)
        if html_body_json['authenticated']:
            for parse_user_nickname in self.list_of_parse_users_nickname:
                yield response.follow(
                    f'/{parse_user_nickname}/',
                    callback=self.user_parse,
                    cb_kwargs={'username': parse_user_nickname}
                )

    def user_parse(self, response: HtmlResponse, username):
        user_id = self.fetch_user_id(response.text, username)
        variables = {'id': user_id,
                     'first': 24}
        first_url_subscribers = f'{self.graphql_url}query_hash={self.query_subscriber_hash}&{urlencode(variables)}'
        first_url_followers = f'{self.graphql_url}query_hash={self.query_follower_hash}&{urlencode(variables)}'
        for i in range(2):
            if i == 1:
                yield response.follow(
                    first_url_subscribers,
                    callback=self.user_data_subscribers_parse,
                    cb_kwargs={'username': username,
                               'user_id': user_id,
                               'variables': deepcopy(variables)})
            else:
                yield response.follow(
                    first_url_followers,
                    callback=self.user_data_followers_parse,
                    cb_kwargs={'username': username,
                               'user_id': user_id,
                               'variables': deepcopy(variables)})

    def user_data_followers_parse(self, response: HtmlResponse, username, user_id, variables):
        j_data = json.loads(response.text)
        page_info = j_data['data']['user']['edge_followed_by']['page_info']
        if page_info['has_next_page']:
            variables['after'] = page_info['end_cursor']
            next_url_followers = f'{self.graphql_url}query_hash={self.query_follower_hash}&{urlencode(variables)}'
            yield response.follow(
                next_url_followers,
                callback=self.user_data_followers_parse,
                cb_kwargs={'username': username,
                           'user_id': user_id,
                           'variables': deepcopy(variables)}
            )

        followers = j_data['data']['user']['edge_followed_by']['edges']
        for follower in followers:
            item = InstaparserItem(
                follower_username=follower['node']['username'],
                follower_fullname=follower['node']['full_name'],
                follower_id=follower['node']['id'],
                follower_profile_pic_url=follower['node']['profile_pic_url'],
                follower_data=follower,
                follower_owner_id=user_id,
                data_type='follow'
            )
            yield item

    def user_data_subscribers_parse(self, response: HtmlResponse, username, user_id, variables):
        j_data = json.loads(response.text)
        page_info = j_data['data']['user']['edge_follow']['page_info']
        if page_info['has_next_page']:
            variables['after'] = page_info['end_cursor']
            next_url_subscribers = f'{self.graphql_url}query_hash={self.query_subscriber_hash}&{urlencode(variables)}'
            yield response.follow(
                next_url_subscribers,
                callback=self.user_data_subscribers_parse,
                cb_kwargs={'username': username,
                           'user_id': user_id,
                           'variables': deepcopy(variables)}
            )

        subscribers = j_data['data']['user']['edge_follow']['edges']
        for subscriber in subscribers:
            item = InstaparserItem(
                subscriber_username=subscriber['node']['username'],
                subscriber_fullname=subscriber['node']['full_name'],
                subscriber_id=subscriber['node']['id'],
                subscriber_profile_pic_url=subscriber['node']['profile_pic_url'],
                subscriber_data=subscriber,
                subscriber_owner_id=user_id,
                data_type='subscribe'
            )
            yield item

    def fetch_csrf_token(self, text):
        matched = re.search('\"csrf_token\":\"\\w+\"', text).group()
        return matched.split(':').pop().replace(r'"', '')

    def fetch_user_id(self, text, username):
        matched = re.search(
            '{\"id\":\"\\d+\",\"username\":\"%s\"}' % username, text
        ).group()
        return json.loads(matched).get('id')
