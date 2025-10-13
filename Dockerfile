# syntax=docker/dockerfile:1
FROM node:22-alpine

WORKDIR /app

# copy package files first
COPY package*.json ./

# install dependencies
RUN npm install --production

# copy all source code
COPY . .

# set environment variable for SQLite DB location
ENV SQLITE_DB_LOCATION=/data/todo.db

# create writable folder
RUN mkdir -p /data

# expose port
EXPOSE 3000

# start the app
CMD ["node", "src/index.js"]

