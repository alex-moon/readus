import requests

class Spring:
    def get_texts(self):
        response = requests.get('http://spring:8080/texts')
        data = response.json()
        texts = data['_embedded']['texts']
        return texts

    def call(self, method, action):
        if method == 'get':
            return requests.get('http://spring:8080%s' % action)
