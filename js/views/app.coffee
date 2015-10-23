@app or= {}

app.AppView = Backbone.View.extend
  el: '#todoapp'
  statsTemplate: Handlebars.compile $('#stats-template').html()
  events:
    'keypress #new-todo': 'createOnEnter'
    'click #clear-completed': 'clearCompleted'
    'click #toggle-all': 'toggleAllComplete'
  initialize: ->
    @allCheckbox = @$('#toggle-all')[0]
    @$input = @$ '#new-todo'
    @$footer = @$ '#footer'
    @$main = @$ '#main'
    @listenTo app.Todos, 'add', @addOne
    @listenTo app.Todos, 'reset', @addAll
    @listenTo app.Todos, 'change:completed', @filterOne
    @listenTo app.Todos, 'filter', @filterAll
    @listenTo app.Todos, 'all', @render
    app.Todos.fetch();
  render: ->
    completed = app.Todos.completed().length
    remaining = app.Todos.remaining().length
    if app.Todos.length
      @$main.show()
      @$footer.show()
      @$footer.html @statsTemplate
          completed: completed
          remaining: remaining
      @$ '#filters li a'
        .removeClass 'selected'
        .filter "[href='#/#{app.TodoFilter or ''}']"
        .addClass 'selected'
    else
      @$main.hide()
      @$footer.hide()
    @allCheckbox.checked = !remaining;
  addOne: (todo)->
    view = new app.TodoView model: todo
    $ '#todo-list'
      .append view.render().el
  addAll: ->
    @$ '#todo-list'
      .html ''
    app.Todos.each @addOne, @
  filterOne: (todo)->
    console.log(todo)
    todo.trigger 'visible'
  filterAll: ->
    app.Todos.each @filterOne, @
  newAttributes: ->
    title: @$input.val().trim()
    order: app.Todos.nextOrder()
    completed: false
  createOnEnter: (e)->
    if e.which is ENTER_KEY and @$input.val().trim()
      app.Todos.create @newAttributes()
      @$input.val ''
  clearCompleted: ->
    _.invoke @app.Todos.completed, 'destroy'
    false
  toggleAllComplete: ->
    completed = @allCheckbox.checked
    app.Todos.each (todo) ->
      todo.save
        'completed':completed


