FROM ubuntu:18.04

LABEL license="MIT License"
LABEL maintainer="christoph.preissner@gmail.com"

RUN apt-get update && apt-get install -y \
	wget \
	dpkg \
	python \
	net-tools

RUN wget https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-clients_5.1.7-1_amd64.deb \
	&& wget https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-server_5.1.7-1_amd64.deb

RUN dpkg -i \
	foundationdb-clients_5.1.7-1_amd64.deb \
	foundationdb-server_5.1.7-1_amd64.deb

RUN apt-get --purge remove -y wget

COPY start-foundationdb.sh /usr/bin/start-foundationdb.sh

RUN chmod 755 /usr/bin/start-foundationdb.sh

ENTRYPOINT ["start-foundationdb.sh"]

EXPOSE 4500
