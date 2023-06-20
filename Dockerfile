FROM crystallang/crystal:1.8.2-alpine

RUN apk update && apk add postgresql-client

WORKDIR /app

COPY ./app/shard.yml ./

RUN shards install

COPY ./app ./

EXPOSE 3000

RUN crystal build src/app.cr

COPY docker-entrypoint.sh ./

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT [ "./docker-entrypoint.sh" ]