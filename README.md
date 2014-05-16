Heroku buildpack: NGINX
=========================

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpack) for compiling and running Google PageSpeed on NGINX.

The example configuration demonstrates how to proxy another web-site.

The NGINX config file is processed using 'erb' to allow the configuration to access the environment variables that you set in Heroku.

'erb' is provided on Heroku dynos by default so there is no dependency on Ruby or any other programming language

Defaults
--------

By default the proxy will point to www.google.com. This is configured by setting PAGESPEED_DOMAIN_TLD on your app.

For example

 $ heroku config:set PAGESPEED_DOMAIN_TLD=mydomain.com

you can also specify another sub-domain than the www default using PAGESPEED_DOMAIN_SUB_DOMAIN

For example

 $ heroku config:set PAGESPEED_DOMAIN_TLD=herokuapp.com PAGESPEED_DOMAIN_SUB_DOMAIN=my-heroku-app
 
Tip: Providing both variables on the same line allows you to (re)set the variables and only restart the app once.

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

You can take advantage of the fact that erb is always ran over the configuration file in the projects that use this buildpack. 

The fact that this buildpack runs erb allows you to expand environment variables that suit your project needs. 

Please take a look at the sample config file to see how easy it is to add config variables that suit your needs.

Known Limitations
-----------------

The buildpack itself does not have any specific limitations, however you should be aware that proxying other domains may give odd results because of the following (non-exhaustive list of) conditions:

- CORS: clients requesting resources from domains other than the one you serve may fail.
- Authentication: Your back end server needs to support X-Forwards

More information can be found by checking the PageSpeed FAQ and the NGINX reverse proxy pages

Hacking
-------

To use this buildpack, fork it on Github.  Push up changes to your fork, then create a test app with `--buildpack <your-github-url>` and push to it.

Commit and push the changes to your buildpack to your Github fork, then push your sample app to Heroku to test. Once the push succeeds you should be able to run:

    $ heroku run bash

and then:

    $ ls -al

and you'll see the nginx and config directories are now present in your slug. You can then start NGINX to prove out the full cycle.

I am happy to take pull requests for improvements and additions.

Contributions
-------------

@kristofsajdak - added subs_filter module [useful when proxying via NGINX]

License
-------

Licensed under the MIT License. See LICENSE file.
