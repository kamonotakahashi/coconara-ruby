FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /newprofile

WORKDIR /newprofile

COPY Gemfile /newprofile/Gemfile
COPY Gemfile.lock /newprofile/Gemfile.lock

#run bundle install
RUN bundle install
COPY . /newprofile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
