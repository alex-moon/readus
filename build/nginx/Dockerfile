FROM nginx:latest

RUN groupadd -g 1000 readus && mkdir /home/readus \
&& useradd -u 1000 -g 1000 -d /home/readus readus

RUN apt-get -y update
RUN apt-get -y install vim less
