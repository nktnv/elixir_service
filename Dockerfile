FROM ruby:2.6-alpine

RUN apk --update --upgrade --no-cache add git build-base postgresql-dev bash

ENV WEB_ROOT /web
RUN mkdir $WEB_ROOT
WORKDIR $WEB_ROOT

EXPOSE 3000
