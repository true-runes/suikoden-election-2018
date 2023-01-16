FROM ruby:3.1.3
ENV LANG C.UTF-8
ARG FOO=bar
ARG HOGE=fuga
RUN echo $FOO
RUN echo $HOGE
RUN FOO=foobar
RUN echo $FOO

RUN --mount=type=secret,id=rails_master_key RAILS_MASTER_KEY=$(cat /run/secrets/rails_master_key)
RUN --mount=type=secret,id=secret_key_base SECRET_KEY_BASE=$(cat /run/secrets/secret_key_base)

RUN apt update -qq && apt install -y build-essential libpq-dev
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
RUN gem install bundler
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler

# TODO: production ビルド前提なので、開発環境として Docker を利用する場合は Dockerfile を分ける
RUN bundle config set --local without 'test development'
RUN bundle install

COPY . /myapp

# production ビルド前提になっている
# RAILS_ENV を逐一指定するのではなく一括で指定してもよい
# RUN --mount=type=secret,id=secret_key_base RAILS_ENV=production RAILS_MASTER_KEY=rails_master_key SECRET_KEY_BASE=secret_key_base bin/rails assets:precompile
# RUN --mount=type=secret,id=rails_master_key --mount=type=secret,id=secret_key_base RAILS_ENV=production RAILS_MASTER_KEY=rails_master_key SECRET_KEY_BASE=secret_key_base bin/rails assets:precompile
# RUN --mount=type=secret,id=rails_master_key --mount=type=secret,id=secret_key_base RAILS_ENV=production RAILS_MASTER_KEY=rails_master_key SECRET_KEY_BASE=secret_key_base bin/rails db:create
# RUN --mount=type=secret,id=rails_master_key --mount=type=secret,id=secret_key_base RAILS_ENV=production RAILS_MASTER_KEY=rails_master_key SECRET_KEY_BASE=secret_key_base bin/rails db:migrate
# RUN --mount=type=secret,id=rails_master_key --mount=type=secret,id=secret_key_base RAILS_ENV=production RAILS_MASTER_KEY=rails_master_key SECRET_KEY_BASE=secret_key_base bin/rails db:seed
RUN RAILS_ENV=production bin/rails assets:precompile
RUN RAILS_ENV=production bin/rails db:create
RUN RAILS_ENV=production bin/rails db:migrate
RUN RAILS_ENV=production bin/rails db:seed

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
