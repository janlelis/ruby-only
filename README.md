# janlelis/ruby-only

A docker base image that installs the latest Ruby via [ruby-install](https://github.com/postmodern/ruby-install).

Based on the [Ruby Dockerfile by Abe Voelker](https://github.com/abevoelker/docker-ruby).

Still tweaking around.

MIT license.


## Usage

This is an example Dockerfile you could use for running an IRB process:

    FROM janlelis/ruby-only
    CMD ["irb"]

You can build it with:

    docker build -t irb-image .

And then run it with:

    docker run -it irb-image
