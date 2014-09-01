# Ruby Base Dockerfile

A Dockerfile that
 * Downloads and builds Ruby via [ruby-install](https://github.com/postmodern/ruby-install)
 * Installs some common Ruby apt dependencies
 * Installs the `bundler` gem

It is meant as a base image and does not start any processes.

Based on the [Ruby Dockerfile by Abe Voelker](https://github.com/abevoelker/docker-ruby).

MIT license.
