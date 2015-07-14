FROM iojs:1.6

MAINTAINER Nick Collings <nick@ustwo.com>

RUN mkdir -p /usr/local/src/logs
RUN mkdir -p /usr/local/src/public

WORKDIR /usr/local/src

ENV TERM=xterm-256color
ENV NODE_ENV=production

COPY package.json /usr/local/src/package.json
RUN npm install --production

COPY bower.json /usr/local/src/bower.json
RUN npm run bower

COPY gulpfile.js /usr/local/src/gulpfile.js
COPY src /usr/local/src/src
RUN npm run compile

VOLUME /usr/local/src/logs

EXPOSE 8888

CMD ["npm", "start"]