FROM ubuntu

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -q -y install ruby ruby-dev build-essential libsqlite3-dev nodejs-legacy nodejs-dev npm

ENV RAILS_ENV="production" \
    SECRET_KEY_BASE="$(openssl rand -base64 32)" \
    DEVISE_SECRET_KEY="290ba109b3ee909f325853f2da0a7efe3bb3f587c33becbbb622c7157459cbcc661755ef69a4f680e8c1c19e3b33c013c71f2061761b1934f8047aa344f6e403"

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc \
    && gem install bundler
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install --without development test --jobs 4
COPY . /app/
RUN bundle exec rake assets:precompile

EXPOSE 3000