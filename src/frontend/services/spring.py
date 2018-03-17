import requests

class Spring:
    def get_texts():
        response = requests.get('http://spring:8888/texts')
        data = response.json()
        texts = data['_embedded']['texts']
        return texts
