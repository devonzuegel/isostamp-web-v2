# IsoStamp 2.0 Website #

## Background for the IsoStamp project & website ##

[Isotopic signature transfer and mass pattern prediction (IsoStamp)](http://pubs.acs.org/doi/abs/10.1021/cb100338x) is an enabling technique for chemically-directed proteomics. Specifically, it is an algorithm for the targeted detection and identification of modified species by mass spectrometry (MS).

This repository contains the code for [isostamp.herokuapp.com](http://isostamp.herokuapp.com/), a web application that enables other people to use IsoStamp to upload and analyze their own data.

For more information: [**Interview with postdocs David Spiciarich and Christina Woo**](https://www.youtube.com/watch?v=ejNOC68xzZM)

## History of the code base ##

This repo contains the code for [isostamp.herokuapp.com](http://isostamp.herokuapp.com/), version 2 of the website. The [original and current official site](http://mass-spec-169.herokuapp.com/) will eventually be deprecated in favor of this new site, and you can find its code at [github.com/cmwoo/mass-spectrometry](https://github.com/cmwoo/mass-spectrometry).


## Ownership ##

As of July 2016:

- [Devon Zuegel](mailto:devonzuegel@gmail.com) has ownership over the Heroku apps (isostamp-staging.herokuapp.com and isostamp.herokuapp.com), Namecheap-hosted domain (isostamp.org), and Mailgun credentials.
- Emails to hello@isostamp.org are forwarded to [Christina Woo](mailto:drcmwoo@gmail.com).
- Emails to admin@isostamp.org are forwarded to [Devon Zuegel](mailto:devonzuegel@gmail.com).

## Deployment Pipeline ##

isostamp relies upon Heroku's deployment pipeline. The structure is as follows:

1. Local development.
2. Deploy to `isostamp-staging` (staging heroku app) by running [`$ rb deploy_staging.rb`](deploy_staging.rb).
3. Promote `isostamp-staging` to `isostamp` (production heroku app) by running [`$ rb deploy_production.rb`](deploy_production.rb).

## Setup ##

> Note: the `$` at the beginning code snippets indicates the command should be run in your terminal. The `$` should not be included in the actual command.

1. [Setup Ruby on Rails on your computer.](https://gorails.com/setup/osx/10.10-yosemite)
2. In your terminal, navigate to the directory in which you'd like to store this repository: `$ cd ~/path/to/parent/dir`. Then, run `$ git clone https://github.com/devonzuegel/isostamp-web-v2.git`.
3. In `~/path/to/parent/dir/isostamp-web-v2`, run `$ bundle install` to install the required Ruby gems.
4. Run `$ guard` to start the server and continuous testing.

## Contact ##

If you come across any problems with the site, please [create a Github issue](https://github.com/devonzuegel/isostamp-web-v2/issues) with specific details and screenshots of the problem.

*Developed by the [Bertozzi Group](http://bertozzigroup.stanford.edu/), 2016.*