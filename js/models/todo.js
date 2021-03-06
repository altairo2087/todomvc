// Generated by CoffeeScript 1.10.0
(function() {
  this.app || (this.app = {});

  app.Todo = Backbone.Model.extend({
    defaults: {
      title: '',
      completed: false
    },
    toggle: function() {
      return this.save({
        completed: !this.get('completed')
      });
    }
  });

}).call(this);

//# sourceMappingURL=todo.js.map
