Isostamp Web V2
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.0
- Rails 4.2.6

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------

---

# IsoStamp 2.0 Website #

## Background for the IsoStamp project & website ##

[Isotopic signature transfer and mass pattern prediction (IsoStamp)](http://pubs.acs.org/doi/abs/10.1021/cb100338x) is an enabling technique for chemically-directed proteomics. Specifically, it is an algorithm for the targeted detection and identification of modified species by mass spectrometry (MS).

This repository contains the code for [REPLACEME.herokuapp.com](http://REPLACEME.herokuapp.com/), a web application that enables other people to use IsoStamp to upload and analyze their own data.

For more information: [**Interview with postdocs David Spiciarich and Christina Woo**](https://www.youtube.com/watch?v=ejNOC68xzZM)

## History of the code base ##

This repository was forked from [github.com/cmwoo/mass-spectrometry](https://github.com/cmwoo/mass-spectrometry). That original repo contains the code for [mass-spec-169.herokuapp.com](http://mass-spec-169.herokuapp.com/), the current production website for the IsoStamp.

This repo contains the code for [REPLACEME.herokuapp.com](http://REPLACEME.herokuapp.com/), version 2 of the website. The [original site](http://mass-spec-169.herokuapp.com/) will eventually be deprecated in favor of this new site.

## Setup ##

> Note: the `$` at the beginning code snippets indicates the command should be run in your terminal. The `$` should not be included in the actual command.

1. [Setup Ruby on Rails on your computer.](https://gorails.com/setup/osx/10.10-yosemite)
2. In your terminal, navigate to the directory in which you'd like to store this repository: `$ cd ~/path/to/parent/dir`. Then, run `$ git clone https://github.com/devonzuegel/isostamp-web.git`.
3. In `~/path/to/parent/dir/isostamp-web`, run `$ bundle install` to install the required Ruby gems. If you get the error `An error occurred while installing libv8 (3.16.14.7), and Bundler cannot continue. Make sure that "gem install libv8 -v '3.16.14.7'" succeeds before bundling.`, try running `$ bundle config build.libv8 --with-system-v8`.

## Contact ##

If you come across any problems with the site, please [create a Github issue](https://github.com/devonzuegel/isoStamp-web/issues) with specific details and screenshots of the problem.

*Developed by the [Bertozzi Group](http://bertozzigroup.stanford.edu/), 2016.*