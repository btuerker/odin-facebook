FROM ruby:2.6.1
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN mkdir /odin-facebook
WORKDIR /odin-facebook
COPY Gemfile /odin-facebook/Gemfile
COPY Gemfile.lock /odin-facebook/Gemfile.lock
RUN gem update --system && gem install bundler && bundler update --bundler
RUN bundle install
COPY . /odin-facebook

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "container"]