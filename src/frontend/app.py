#!/usr/bin/env python

from tornado import websocket
from tornado.ioloop import IOLoop

import tornado
import os

class EchoHandler(websocket.WebSocketHandler):
    def open(self, *args, **kwargs):
        self.application.pc.add_event_listener(self)

    def on_message(self, message):
        self.write_message(json.dumps({'message': message}))

    def on_close(self):
        self.application.pc.remove_event_listener(self)

class ExampleHandler(tornado.web.RequestHandler):
    def get(self):
        from services import spring
        self.set_header("Content-Type", "text/plain")
        for text in spring.Spring.get_texts():
            self.write("%s\n%s\n\n" % (text['uuid'], text['rawText']))

class IndexHandler(tornado.web.RequestHandler):
    def get(self, path=None):
        self.render('web/index.html')

if __name__ == "__main__":
    application = tornado.web.Application([
        (r"^/echo", EchoHandler),
        (r"^/(.*)", IndexHandler),
    ])
    server = tornado.httpserver.HTTPServer(application)
    server.bind(8000)
    server.start(0)
    IOLoop.current().start()
