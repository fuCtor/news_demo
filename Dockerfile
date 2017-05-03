FROM ruby:2.4
ARG secret

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN gem install bundler --no-ri --no-rdoc

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle config --global --jobs 8
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test --deployment

ADD . /app

ENV RAILS_ENV production

RUN bundle exec rails SECRET_KEY_BASE="$secret" assets:precompile
RUN bundle exec rails SECRET_KEY_BASE="$secret" db:create db:migrate db:seed

expose 3000