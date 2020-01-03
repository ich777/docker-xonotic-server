FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl unzip && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV BASIC_URL="https://dl.xonotic.org/"
ENV GAME_VERSION="0.8.2"
ENV GAME_PARAMS="template"
ENV GAME_PORT=26000
ENV UMASK=000
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID xonotic && \
	chown -R xonotic $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/ && \
	chown -R xonotic /opt/scripts

USER xonotic

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]