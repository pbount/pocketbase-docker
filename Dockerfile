FROM alpine:3.18.0

ARG POCKETBASE_VERSION=0.16.1

RUN apk update && apk add curl wget unzip
RUN addgroup -S pocketbase && adduser -S pocketbase -G pocketbase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip -O '/tmp/pocketbase.zip'
RUN unzip /tmp/pocketbase.zip -d /
RUN rm /tmp/pocketbase.zip

RUN mkdir /pb_data
RUN mkdir /pb_public

RUN chown pocketbase:pocketbase /pb_data
RUN chown pocketbase:pocketbase /pb_public

VOLUME /pb_data
VOLUME /pb_public
USER pocketbase

EXPOSE 8090

ENTRYPOINT ["/pocketbase", "serve", "--http=0.0.0.0:8090"]
