FROM node:lts
RUN apt-get update
RUN apt-get install openjdk-11-jre curl -y && \
    npm i -G firebase-tools && \
    firebase setup:emulators:database && \
    firebase setup:emulators:firestore && \
    firebase setup:emulators:pubsub && \
    firebase setup:emulators:storage && \
    firebase -V && \
    java -version
SHELL ["/bin/bash", "-c"]
ENV BASH_ENV ~/.bashrc
# needed by volta() function
ENV VOLTA_HOME /root/.volta
# make sure packages managed by volta will be in PATH
ENV PATH $VOLTA_HOME/bin:$PATH

# install volta
RUN curl https://get.volta.sh | bash

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
