#!/usr/bin/env python

from tornado import websocket
from tornado.ioloop import IOLoop

import tornado
import os
import json

from services import spring

class WebSocketHandler(websocket.WebSocketHandler):
    def on_message(self, message):
        if message['method'] and message['action']:
            self.write_message(
                self.application.spring.call(message['method'], message['action'])
            )
        
        self.write_message(json.dumps({'message': message}))

class ExampleHandler(tornado.web.RequestHandler):
    def get(self):
        self.set_header("Content-Type", "text/plain")
        for text in self.application.spring.get_texts():
            self.write("%s\n%s\n\n" % (text['uuid'], text['rawText']))

class IndexHandler(tornado.web.RequestHandler):
    def get(self, path=None):
        self.render('web/dist/index.html')

if __name__ == "__main__":
    application = tornado.web.Application([
        (r"^/echo", WebSocketHandler),
        (r"^/(.*)", IndexHandler),
    ])
    application.spring = spring.Spring()
    server = tornado.httpserver.HTTPServer(application)
    server.bind(8000)
    server.start(0)
    IOLoop.current().start()
