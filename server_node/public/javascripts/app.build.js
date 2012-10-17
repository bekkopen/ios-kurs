({
  appDir: "../",
  baseUrl: "javascripts",
  dir: "../../app-build/",
  //Comment out the optimize line if you want
  //the code minified by UglifyJS
  optimize: "none",

  paths: {
    "jquery": "libs/jquery",
    "underscore": "libs/underscore", 
    "backbone": "libs/backbone"
  },

  modules: [
    {
      name: "main",
    }
  ]
})