FROM ubuntu:16.04

RUN apt-get update && apt-get install -y sudo wget dpkg python

RUN wget https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-clients_5.1.7-1_amd64.deb \
	&& wget https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-server_5.1.7-1_amd64.deb
	
RUN sudo dpkg -i foundationdb-clients_5.1.7-1_amd64.deb \
	foundationdb-server_5.1.7-1_amd64.deb

COPY foundationdb.conf /etc/foundationdb/foundationdb.conf

CMD service foundationdb start && tail -f /var/log/foundationdb/trace*

EXPOSE 4500
