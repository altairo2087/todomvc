Workspace = Backbone.Router.extend
  routes:
    '*filter': 'setFilter'
  setFilter: (param)->
    app.TodoFilter = param or ''
    window.app.Todos.trigger 'filter'

app.TodoRouter = new Workspace()
Backbone.history.start()
