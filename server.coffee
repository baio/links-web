express = require 'express'
Bliss = require 'bliss'

app = express()
bliss = new Bliss(cacheEnabled: false, ext: "bliss")



app.engine '.bliss', (path,options,callback) ->
  callback null, bliss.render(path, options)

app.get '/', (req, res) ->
  res.render "_layout.bliss", title : "Wellcome!"

app.use(express.static("public"))
    .listen process.env.PORT | 8085