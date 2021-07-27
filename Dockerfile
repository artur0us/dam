FROM node:lts-alpine

RUN mkdir -p /files

ARG PROXY
ARG NO_PROXY
ARG NPM_REGISTRY
ARG REMOTE_URL
ENV NO_PROXY $NO_PROXY
ENV HTTP_PROXY $PROXY
ENV HTTPS_PROXY $PROXY
ENV FS_DIRECTORY '/files/'

RUN apk add --update --no-cache g++ gcc libgcc libstdc++ linux-headers make python

RUN npm config set registry $NPM_REGISTRY/npm-all/

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build:dev

EXPOSE 8080

CMD [ "npm", "run", "start:dev"]
