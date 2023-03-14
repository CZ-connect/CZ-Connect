FROM node:18.14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

EXPOSE 3000

RUN chmod +x ./entrypoint.sh ./wait-for-it.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "node", "./src/applicantforms.js" ]