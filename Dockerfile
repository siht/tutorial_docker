FROM node:10.16.3-alpine

COPY . /app
WORKDIR /app
RUN npm i --only=prod
CMD ["node", "server.js"]