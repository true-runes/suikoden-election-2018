FROM ruby:3.2.1
ENV LANG C.UTF-8
ARG NODEJS_MAJOR_VERSION=16.x
ARG NODEJS_PATCH_VERSION=16.19.0
ARG YARN_VERSION=1.22.19

RUN apt update -qq && apt install -y build-essential libpq-dev
RUN curl -o nodejs.deb https://deb.nodesource.com/node_$NODEJS_MAJOR_VERSION/pool/main/n/nodejs/nodejs_$NODEJS_PATCH_VERSION-deb-1nodesource1_amd64.deb && \
    apt install -y ./nodejs.deb && \
    rm nodejs.deb
RUN npm install -g yarn@$YARN_VERSION
RUN gem install bundler

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# production ビルド前提なので、開発環境として Docker を利用する場合は Dockerfile を分ける
RUN bundle config set --local without 'test development'
RUN bundle install

COPY . /myapp

# production ビルド前提になっている
RUN --mount=type=secret,id=rails_master_key RAILS_ENV=production RAILS_MASTER_KEY=$(cat /run/secrets/rails_master_key) bin/rails assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
