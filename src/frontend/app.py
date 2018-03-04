#!/usr/bin/env python

from tornado import websocket
from tornado.ioloop import IOLoop

import tornado

class EchoHandler(websocket.WebSocketHandler):
    def open(self, *args, **kwargs):
        self.application.pc.add_event_listener(self)

    def on_message(self, message):
        self.write_message(json.dumps({'message': message}))

    def on_close(self):
        self.application.pc.remove_event_listener(self)

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

if __name__ == "__main__":
    application = tornado.web.Application([
        (r"^/echo", EchoHandler),
        (r"^/", MainHandler),
    ])
    server = tornado.httpserver.HTTPServer(application)
    server.bind(8000)
    server.start(0)
    IOLoop.current().start()
