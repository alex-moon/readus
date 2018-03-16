FROM kdelfour/supervisor-docker

RUN groupadd -g 1000 readus && mkdir /home/readus \
&& useradd -u 1000 -g 1000 -d /home/readus readus

COPY requirements.txt /tmp/requirements.txt

RUN apt-get -y update
RUN apt-get -y install vim less python3.4 python3-pip ca-certificates

RUN pip3 install -r /tmp/requirements.txt
