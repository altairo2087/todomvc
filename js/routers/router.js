// Generated by CoffeeScript 1.10.0
(function() {
  var Workspace;

  Workspace = Backbone.Router.extend({
    routes: {
      '*filter': 'setFilter'
    },
    setFilter: function(param) {
      app.TodoFilter = param || '';
      return window.app.Todos.trigger('filter');
    }
  });

  app.TodoRouter = new Workspace();

  Backbone.history.start();

}).call(this);

//# sourceMappingURL=router.js.map
