FROM ruby:2.2.0

RUN apt-get update -qq && apt-get install -y build-essential \
    libpq-dev nodejs qt5-default libqt5webkit5-dev \
    gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    xvfb chromium iceweasel

RUN mkdir /PartyPlaylist

WORKDIR /PartyPlaylist

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install

ADD . ./
