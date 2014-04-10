Heroku buildpack: Java
=========================

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpack) for installing NGINX

Usage
-----

Example usage:

    $ ls
    Procfile  nginx.conf

    $ heroku create --stack cedar --buildpack <this buildpack>

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

and you'll see the .m2 and .maven directories are now present in your slug.

License
-------

Licensed under the MIT License. See LICENSE file.
