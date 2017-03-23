# Guardians of Dreams Admin Interface

[![Build Status](https://travis-ci.org/godreams/admin-server.svg?branch=master)](https://travis-ci.org/godreams/admin-server)
[![Coverage Status](https://coveralls.io/repos/github/godreams/admin-server/badge.svg?branch=master)](https://coveralls.io/github/godreams/admin-server?branch=master)
[![Code Climate](https://codeclimate.com/github/godreams/admin-server/badges/gpa.svg)](https://codeclimate.com/github/godreams/admin-server)

## Development Setup

1. Install [rbenv](https://github.com/rbenv/rbenv) and [rbenv/ruby-build](https://github.com/rbenv/ruby-build). Follow instructions to properly set it up (or use _rvm_ if that's what you prefer).
1. Install Ruby 2.4.0: `rbenv install 2.4.0`
2. Install [bundler](https://bundler.io): `gem install bundler`
3. Install dependencies: `bundle install`

## Execution

To run the server:

```
bundle exec rails server
```

Now open [localhost:3000](http://localhost:3000) in your browser.
