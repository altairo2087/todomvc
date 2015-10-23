@app or= {}

TodoList = Backbone.Collection.extend
  model: app.Todo
  localStorage: new Backbone.LocalStorage 'todos-backbone'
  completed: ->
    @filter (todo) ->
      todo.get 'completed'
  remaining: ->
    @without.apply @, @completed()
  nextOrder: ->
    if @length then @last().get('order') + 1 else 1
  comparator: (todo)->
    todo.get 'order'

app.Todos = new TodoList
