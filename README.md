# janlelis/ruby-only

An ubuntu based docker image that installs the latest Ruby via [ruby-install](https://github.com/postmodern/ruby-install).

## Version Strategy

You can specify a Ruby version using it as a docker tag. It will lead to the respective branch on this repo. The branches will be updated, when the Dockerfile structure is changed. If you want to ensure that you will always get the very same Dockerfile, add "-fixed" to your docker tag, which will lead to git tags in this repo.

## Usage

This is an example Dockerfile you could use for running an IRB process:

    FROM janlelis/ruby-only
    CMD ["irb"]

You can build it with:

    docker build -t irb-image .

And then run it with:

    docker run -it irb-image

## MIT-License

Originally based on the [Ruby Dockerfile by Abe Voelker](https://github.com/abevoelker/docker-ruby).
