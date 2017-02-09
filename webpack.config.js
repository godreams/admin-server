var path = require('path')

var BUILD_DIR = path.resolve(__dirname, 'public')
var APP_DIR = path.resolve(__dirname, 'components')
var SERVICES_DIR = path.resolve(__dirname, 'services')

var config = {
  entry: APP_DIR + '/index.jsx',
  output: {
    path: BUILD_DIR,
    filename: 'bundle.js'
  },
  devServer: {
    historyApiFallback: true
  },
  resolve: {
    modules: [APP_DIR, SERVICES_DIR, 'node_modules'],
    extensions: ['.js', '.scss', '.css', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.jsx?/,
        include: APP_DIR,
        use: [{loader: 'babel-loader'}]
      },
      {
        test: /\.scss$/,
        use: [
          {loader: 'style-loader'},
          {loader: 'css-loader'},
          {
            loader: 'sass-loader',
            options: {
              includePaths: [
                './node_modules'
              ]
            }
          }
        ]
      }
    ]
  }
}

module.exports = config
