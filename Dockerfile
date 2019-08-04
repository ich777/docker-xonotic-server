FROM ubuntu

MAINTAINER ich777

RUN apt-get update
RUN apt-get -y install wget unzip

ENV DATA_DIR="/serverdata"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV BASIC_URL="https://dl.xonotic.org/"
ENV GAME_VERSION="0.8.2"
ENV GAME_PARAMS="template"
ENV GAME_PORT=27015
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID xonotic
RUN chown -R xonotic $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R xonotic /opt/scripts

USER xonotic

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
