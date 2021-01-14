## Requirements
The list of requirements to install this app are:
* Ruby >= 3.0.x

## Installation
* `` git clone https://github.com/resgar/MS-coding-challenge.git``
* `` bundle install ``

* Create a file named ```local_env.yml``` in ```config``` directory and add your **Space ID** and **Access Token** there:
```
CONTENTFUL_ACCESS_TOKEN: "Your Access Token"
CONTENTFUL_SPACE_ID: "Your Space ID"
```

* `` bundle exec rails server ``

## Running in production mode
* `` RAILS_ENV=production rails assets:precompile ``
* `` RAILS_ENV=production rails s ``

## Running tests
```
bundle exec rails test
```
