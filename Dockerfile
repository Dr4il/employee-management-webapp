FROM node:6.11.0
RUN curl -o- -L https://yarnpkg.com/install.sh | \  bash -s -- --version 0.26.1
RUN yarn global add nodemon@1.11.0

RUN mkdir -p /usr/src/app

ADD .yarn_cache /usr/local/share/.cache/yarn/v1/

ADD ./package.json ./yarn.* /tmp/
RUN cd /tmp && yarn
RUN cd /usr/src/app && ln -s /tmp/node_modules

ADD . /usr/src/app/
EXPOSE 3000

WORKDIR /usr/src/app
