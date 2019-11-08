FROM buildkite/puppeteer

LABEL MAINTAINER="Xudong Cai <fifsky@gmail.com>"

ENTRYPOINT ["node", "/lib/main.js"]

COPY . .

RUN mv simsun.ttf /usr/local/share/fonts/

RUN npm install --production
