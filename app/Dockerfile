FROM ruby:2.5
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
ENV APP_HOME /yuruspo_bot
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . /yuruspo_bot