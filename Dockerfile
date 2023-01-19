FROM node:lts
WORKDIR /app
RUN apt-get update
RUN apt-get install openjdk-11-jre curl -y
RUN npm i -G firebase-tools
RUN npx firebase setup:emulators:database && \
    npx firebase setup:emulators:firestore && \
    npx firebase setup:emulators:pubsub && \
    npx firebase setup:emulators:storage
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
