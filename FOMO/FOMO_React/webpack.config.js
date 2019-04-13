var webpack = require("webpack");
var path = require("path");

module.exports = {
  output: {
    path: path.resolve(__dirname, "public"), 
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      }
    ]
  },
};