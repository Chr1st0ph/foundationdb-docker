FROM ubuntu:18.04

LABEL license="MIT License"
LABEL maintainer="christoph.preissner@gmail.com"

RUN apt-get update && apt-get install -y \
	wget \
	dpkg \
	python \
	net-tools \
	netcat

RUN wget https://www.foundationdb.org/downloads/6.0.15/ubuntu/installers/foundationdb-clients_6.0.15-1_amd64.deb \
	&& wget https://www.foundationdb.org/downloads/6.0.15/ubuntu/installers/foundationdb-server_6.0.15-1_amd64.deb

RUN dpkg -i \
	foundationdb-clients_6.0.15-1_amd64.deb \
	foundationdb-server_6.0.15-1_amd64.deb

RUN apt-get --purge remove -y wget

COPY start-foundationdb.sh /usr/bin/start-foundationdb.sh

RUN chmod 755 /usr/bin/start-foundationdb.sh

ENTRYPOINT ["start-foundationdb.sh"]

EXPOSE 4500
