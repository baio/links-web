// Generated by CoffeeScript 1.6.2
(function() {
  var Bliss, app, bliss, express;

  express = require('express');

  Bliss = require('bliss');

  app = express();

  bliss = new Bliss({
    cacheEnabled: false,
    ext: "bliss"
  });

  app.engine('.bliss', function(path, options, callback) {
    return callback(null, bliss.render(path, options));
  });

  app.get('/', function(req, res) {
    return res.render("_layout.bliss", {
      title: "Wellcome!"
    });
  });

  app.use(express["static"]("public")).listen(process.env.PORT | 8085);

}).call(this);
