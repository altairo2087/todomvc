// Generated by CoffeeScript 1.10.0
(function() {
  this.app || (this.app = {});

  app.AppView = Backbone.View.extend({
    el: '#todoapp',
    statsTemplate: Handlebars.compile($('#stats-template').html()),
    events: {
      'keypress #new-todo': 'createOnEnter',
      'click #clear-completed': 'clearCompleted',
      'click #toggle-all': 'toggleAllComplete'
    },
    initialize: function() {
      this.allCheckbox = this.$('#toggle-all')[0];
      this.$input = this.$('#new-todo');
      this.$footer = this.$('#footer');
      this.$main = this.$('#main');
      this.listenTo(app.Todos, 'add', this.addOne);
      this.listenTo(app.Todos, 'reset', this.addAll);
      this.listenTo(app.Todos, 'change:completed', this.filterOne);
      this.listenTo(app.Todos, 'filter', this.filterAll);
      this.listenTo(app.Todos, 'all', this.render);
      return app.Todos.fetch();
    },
    render: function() {
      var completed, remaining;
      completed = app.Todos.completed().length;
      remaining = app.Todos.remaining().length;
      if (app.Todos.length) {
        this.$main.show();
        this.$footer.show();
        this.$footer.html(this.statsTemplate({
          completed: completed,
          remaining: remaining
        }));
        this.$('#filters li a').removeClass('selected').filter("[href='#/" + (app.TodoFilter || '') + "']").addClass('selected');
      } else {
        this.$main.hide();
        this.$footer.hide();
      }
      return this.allCheckbox.checked = !remaining;
    },
    addOne: function(todo) {
      var view;
      view = new app.TodoView({
        model: todo
      });
      return $('#todo-list').append(view.render().el);
    },
    addAll: function() {
      this.$('#todo-list').html('');
      return app.Todos.each(this.addOne, this);
    },
    filterOne: function(todo) {
      return todo.trigger('visible');
    },
    filterAll: function() {
      return app.Todos.each(this.filterOne, this);
    },
    newAttributes: function() {
      return {
        title: this.$input.val().trim(),
        order: app.Todos.nextOrder(),
        completed: false
      };
    },
    createOnEnter: function(e) {
      if (e.which === ENTER_KEY && this.$input.val().trim()) {
        app.Todos.create(this.newAttributes());
        return this.$input.val('');
      }
    },
    clearCompleted: function() {
      _.invoke(this.app.Todos.completed, 'destroy');
      return false;
    },
    toggleAllComplete: function() {
      var completed;
      completed = this.allCheckbox.checked;
      return app.Todos.each(function(todo) {
        return todo.save({
          'completed': completed
        });
      });
    }
  });

}).call(this);

//# sourceMappingURL=app.js.map