# # #
# Base Dockerfile for Ruby applications
# # #

FROM ubuntu:trusty
MAINTAINER Jan Lelis <mail@janlelis.de>
ENV DEBIAN_FRONTEND noninteractive

# Ensure locale
RUN apt-get -y update
RUN dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Essential packages
RUN apt-get -y update
RUN apt-get -y install wget build-essential git

# Ruby dependencies
RUN apt-get -y install bison flex libmagickwand-dev libreadline-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev

# Get ruby-install source
WORKDIR /tmp
RUN wget -O ruby-install-0.4.3.tar.gz \
  https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
RUN wget https://raw.github.com/postmodern/ruby-install/master/pkg/ruby-install-0.4.3.tar.gz.asc

# Verify it is ruby-install
ADD ./postmodern.asc /tmp/postmodern.asc
RUN gpg --no-default-keyring --import postmodern.asc
RUN gpg --verify ruby-install-0.4.3.tar.gz.asc \
  ruby-install-0.4.3.tar.gz

# Install ruby-install
RUN tar -xzvf ruby-install-0.4.3.tar.gz
WORKDIR ruby-install-0.4.3/
RUN make install

# Install actual Ruby
RUN ruby-install ruby 2.1.2

# Set $PATH so that non-login shells will see the Ruby binaries
ENV PATH $PATH:/opt/rubies/ruby-2.1.2/bin

# Add Ruby binaries to $PATH
ADD ./ruby.sh /etc/profile.d/ruby.sh
RUN chmod a+x /etc/profile.d/ruby.sh

# Never install Ruby docs
RUN echo "install: --no-rdoc --no-ri\nupdate: --no-rdoc --no-ri" > /etc/gemrc

# Install global gems
RUN /bin/bash -l -c 'gem install bundler'

# Cleaning...
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

