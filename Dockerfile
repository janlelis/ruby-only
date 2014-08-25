# # #
# Base Dockerfile for Ruby applications
# # #

FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

# Ensure Locale
RUN apt-get -y update
RUN dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Packages
RUN apt-get -y update
RUN apt-get -y install wget build-essential git

# Ruby dependencies
RUN apt-get -y install bison flex imagemagick libreadline-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev

# Install ruby-install
RUN cd /tmp &&\
  wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz &&\
  tar -xzvf ruby-install-0.4.3.tar.gz &&\
  cd ruby-install-0.4.3/ &&\
  make install

# Install latest MRI
RUN ruby-install ruby 2.1.2

# Set $PATH so that non-login shells will see the Ruby binaries
ENV PATH $PATH:/opt/rubies/ruby-2.1.2/bin

# Add Ruby binaries to $PATH
ADD ./ruby.sh /etc/profile.d/ruby.sh
RUN chmod a+x /etc/profile.d/ruby.sh

# Never install Ruby docs
RUN echo "install: --no-rdoc --no-ri\nupdate: --no-rdoc --no-ri" > /etc/gemrc

# Install bundler gem
RUN /bin/bash -l -c 'gem install bundler'

# Cleaning...
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

