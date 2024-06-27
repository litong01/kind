FROM golang:1.22.4-alpine3.20 as KINDBUILDER
RUN apk update && apk add --no-cache make 
RUN mkdir -p /go/src/github.com/kind
COPY . /go/src/github.com/kind
RUN cd ./src/github.com/kind && make build

FROM alpine:3.20
LABEL maintainer="litong01"

COPY --from=KINDBUILDER /go/src/github.com/kind/bin/kind /usr/local/bin
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/* && apk update
ENV HOME=/home
WORKDIR /home