FROM node:10.16.3-alpine

COPY ./src/node_api_test /app
WORKDIR /app
RUN npm i --only=prod
CMD ["node", "server.js"]