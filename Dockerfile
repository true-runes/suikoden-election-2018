FROM ruby:3.4.3
ENV LANG C.UTF-8
ARG NODEJS_VERSION=$(cat .node-version)
ARG YARN_VERSION=1.22.19

RUN apt update -qq && apt install -y build-essential libpq-dev
RUN apt install -y nodejs npm && npm install -g n && n $NODEJS_VERSION && npm install -g yarn@$YARN_VERSION
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
# TODO: NODE_OPTIONS="--openssl-legacy-provider" は一時的な回避策なので、将来的には削除すべきである
RUN --mount=type=secret,id=rails_master_key RAILS_ENV=production RAILS_MASTER_KEY=$(cat /run/secrets/rails_master_key) NODE_OPTIONS="--openssl-legacy-provider" bin/rails assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
