FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

# Set $PATH so that non-login shells will see the Ruby binaries
ENV PATH $PATH:/opt/rubies/ruby-2.1.2/bin

# Ensure UTF-8 locale
RUN echo "LANG=\"en_US.UTF-8\"" > /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update

# Install dependencies
RUN apt-get install -y \
  wget \
  build-essential \
  libcurl4-openssl-dev \
  libreadline-dev \
  flex \
  bison \
  libxml2-dev \
  libxslt1-dev \
  libssl-dev \
  imagemagick \
  zlib1g-dev

# Install ruby-install
RUN cd /tmp &&\
  wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz &&\
  tar -xzvf ruby-install-0.4.3.tar.gz &&\
  cd ruby-install-0.4.3/ &&\
  make install

RUN apt-get update

# Install MRI Ruby 2.1.2
RUN ruby-install ruby 2.1.2

# Add Ruby binaries to $PATH
ADD ./ruby.sh /etc/profile.d/ruby.sh
RUN chmod a+x /etc/profile.d/ruby.sh

# Install bundler gem globally
RUN /bin/bash -l -c 'gem install bundler'

# Clean up APT and temporary files when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

