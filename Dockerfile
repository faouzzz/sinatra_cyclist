FROM ruby:2.3-alpine
MAINTAINER nfa
RUN apk --update --no-cache add \
  build-base \
  nodejs \
  zlib-dev \
  libxml2-dev \
  libxslt-dev \
  sqlite-dev \
  tzdata \
  git \
  && rm -rf /var/cache/apk/*

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime &&\
  echo "Europe/Paris" >  /etc/timezone

RUN bundle config --global build.nokogiri  "--use-system-libraries" &&\
  bundle config --global build.nokogumbo "--use-system-libraries" &&\
  echo 'gem: --no-doc --no-ri' >> ~/.gemrc && chmod +r ~/.gemrc

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN gem install dashing
RUN dashing new . &&\
  rm -f dashboards/sample* jobs/*.rb &&\
  bundle
COPY test/dashing/ ./
COPY . ./lib/sinatra_cyclist_multi
RUN rm -rf ./lib/sinatra_cyclist_multi/examples

EXPOSE 8080:3030
CMD dashing start