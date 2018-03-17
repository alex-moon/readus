# readus
Social Network for Text Files

## Getting Started

First up, install docker-machine. Then:

```
./run.sh
```

To force a rebuild, simply:

```
./clean.sh
./run.sh
```

## The Stack

We wanted to play with a front-end/back-end split on the server side, and to build a client that
a) respects HATEOAS principles and b) can do real-time updates. The stack looks like this:

Vue.js
Tornado (behind nginx, so we can host static files in a dumb manner)
Spring HATEOAS
Neo4J

When you run `run.sh` you'll be given an IP address. Add an entry to your /etc/hosts
for this IP address:
```
192.168.0.100 readus
```
then go to your browser:

readus: http://readus
Spring: http://readus:8888
Neo4J: http://readus:7474

That's right! Spring HATEOAS and Neo4J both host user-friendly dashboards out of the box, which
makes development a breeze.
