FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /result_system
WORKDIR /result_system
COPY Gemfile /result_system/Gemfile
COPY Gemfile.lock /result_system/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /result_system
ADD . $HOME

CMD ["rails", "server", "-b", "0.0.0.0"]
