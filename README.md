# Guardians of Dreams Admin Interface

This is a hybrid repository, containing both a Rails API and a React client application.

## Development Setup

### Server

1. Install [rvm](https://rvm.io)
2. Install Ruby 2.3.3: `rvm install 2.3.3`
3. Install [bundler](https://bundler.io): `gem install bundler`
4. Install dependencies: `bundle install`

### Client

1. Install [nvm](https://github.com/creationix/nvm), and then the latest version of node.
2. Install [yarn](https://yarnpkg.com): `brew update && brew install yarn`
3. Install _webpack_ globally: `yarn global add webpack@beta`
4. Install dependencies using `yarn install`

## Execution

To set up updating bundle.js

```
webpack --watch
```

```
bundle exec rails server
```

Now open [localhost:3000](http://localhost:3000) in your browser.

Note that the Rails application will serve `public/index.html`, which will load the client application built by Webpack.
