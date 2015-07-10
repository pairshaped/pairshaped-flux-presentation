var webpack = require('webpack');

module.exports = {
  entry: {
    full: "./scripts/index.coffee"
  },
  output: {
    path: "./dist",
    publicPath: '/',
    filename: "[name].entry.js"
  },

  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.sass$/, loader: "style-loader!css-loader!sass?indentedSyntax" }
    ]
  },
  resolve: {
    extensions: ["", ".js", ".coffee", ".sass"]
  },
  plugins: [
    new webpack.ProvidePlugin({
      "React": "react/addons",
      "Flux": "flux",
      "_": "lodash",
      "Bemmer": "bemmer-node/bemmer-class",
      "uuid": "node-uuid"
    })
  ],
  devServer: {
    port: 8080
  }
};

