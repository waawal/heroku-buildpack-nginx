Heroku buildpack: NGINX
=========================

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpack) for compiling and running Google PageSpeed on NGINX.

The example configuration demonstrates how to proxy another web-site.

The NGINX config file is processed using 'erb' to allow the configuration to access the environment variables that you set in Heroku.

'erb' is provided on Heroku dynos by default so there is no dependency on Ruby or any other programming language

Usage
-----

Example usage:

    $ ls
    Procfile  nginx.conf.erb

    $ heroku create --buildpack https://github.com/raymcdermott/heroku-buildpack-nginx

    $ git push heroku master
    ...
    -----> Heroku receiving push
    -----> Fetching custom language pack... done
    -----> NGINX detected
    ...


Hacking
-------

To use this buildpack, fork it on Github.  Push up changes to your fork, then create a test app with `--buildpack <your-github-url>` and push to it.

Commit and push the changes to your buildpack to your Github fork, then push your sample app to Heroku to test. Once the push succeeds you should be able to run:

    $ heroku run bash

and then:

    $ ls -al

and you'll see the nginx and config directories are now present in your slug.

License
-------

Licensed under the MIT License. See LICENSE file.
