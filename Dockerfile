ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-buster

ARG PG_MAJOR

# Add PostgreSQL to sources list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch"-pgdg main | tee  /etc/apt/sources.list.d/pgdg.list

# Add Node.js to sources list
ARG NODE_MAJOR
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    nodejs \
    postgresql-client-$PG_MAJOR

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn apt-key add - && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install --no-install-recommends yarn

# Clean up files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

# Configure bundler and node PATH
ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV NODE_PATH /node_modules

ENV PATH /workspace/bin:$BUNDLE_BIN:$NODE_PATH:$PATH

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler --no-doc

# Install rails
ARG RAILS_VERSION
RUN gem install rails -v $RAILS_VERSION --no-document

# Create a directory for the worspace code
RUN mkdir -p /workspace

WORKDIR /workspace
