ARG NODE_VERSION=12.18.3
FROM node:${NODE_VERSION}

ARG YARN_VERSION=1.22.4

RUN \
if command -v apt-get &> /dev/null ; then \
    [ -z "$(command -v curl)" ] && apt-get update && apt-get install -y curl || echo 'curl available' && \
    apt-get update && apt-get install -y gnupg2 && \
    apt-get install -y apt-transport-https ca-certificates && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn=${YARN_VERSION}-1; \
elif command -v apk &> /dev/null ; then \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk add yarn=~${YARN_VERSION}; \
else \
    echo "Unsupported base os..." && exit 1; \
fi
