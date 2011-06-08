bootApplication = (app) ->
  app.use express.logger(":method :url :status")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(secret: "keyboard cat")
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.error (err, req, res) ->
    console.dir err
    res.render "500"
  
  app.use (req, res) ->
    res.render "404"
  
  app.set "views", __dirname + "/views"
  app.register ".html", require("ejs")
  app.set "view engine", "html"
  app.dynamicHelpers 
    request: (req) ->
      req
    
    hasMessages: (req) ->
      if not req.session
        return false
      Object.keys(req.session.flash or {}).length
    
    messages: (req) ->
      ->
        msgs = req.flash()
        Object.keys(msgs).reduce((arr, type) ->
          arr.concat(msgs[type])
        , [  ])
bootControllers = (app) ->
  fs.readdir __dirname + "/controllers", (err, files) ->
    if err
      throw err
    files.forEach (file) ->
      bootController app, file
bootController = (app, file) ->
  name = file.replace(".js", "")
  actions = require("./controllers/" + name)
  plural = name + "s"
  prefix = "/" + plural
  if name == "app"
    prefix = "/"
  Object.keys(actions).map (action) ->
    fn = controllerAction(name, plural, action, actions[action])
    switch action
      when "index"
        app.get prefix, fn
      when "show"
        app.get prefix + "/:id.:format?", fn
      when "add"
        app.get prefix + "/:id/add", fn
      when "create"
        app.post prefix + "/:id", fn
      when "edit"
        app.get prefix + "/:id/edit", fn
      when "update"
        app.put prefix + "/:id", fn
      when "destroy"
        app.del prefix + "/:id", fn
controllerAction = (name, plural, action, fn) ->
  (req, res, next) ->
    render = res.render
    format = req.params.format
    path = __dirname + "/views/" + name + "/" + action + ".html"
    res.render = (obj, options, fn) ->
      res.render = render
      if typeof obj is "string"
        return res.render(obj, options, fn)
      if action == "show" and format
        if format is "json"
          return res.send(obj)
        else
          throw new Error("unsupported format \"" + format + "\"")
      res.render = render
      options = options or {}
      if action == "index"
        options[plural] = obj
      else
        options[name] = obj
      res.render(path, options, fn)
    
    fn.apply this, arguments
fs = require("fs")
express = require("../../lib/express")
exports.boot = (app) ->
  bootApplication app
  bootControllers app