@app or= {}

app.TodoView = Backbone.View.extend
  tagName: 'li'
  template: Handlebars.compile $("#item-template").html()
  events:
    'click .toggle': 'togglecompleted'
    'dblclick label':'edit'
    'click .destroy': 'clear'
    'keypress .edit': 'updateOnEnter'
    'blur .edit': 'close'
  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove
    @listenTo @model, 'visible', @toggleVisible
  render: ->
    @$el.html @template @model.toJSON()
    @$el.toggleClass 'completed', @model.get 'completed'
    @toggleVisible()
    @$input = @$ '.edit'
    @
  toggleVisible: ->
    @$el.toggleClass 'hidden', @isHidden()
  isHidden: ->
    isCompleted = @model.get 'completed'
    ((not isCompleted and app.TodoFilter is 'completed') or
      (isCompleted and app.TodoFilter is 'active'))
  togglecompleted: ->
    @model.toggle()
  edit: ->
    @$el.addClass 'editing';
    @$input.focus();
  close: ->
    value = @$input.val().trim()
    if value
      @model.save title: value
    @$el.removeClass 'editing'
  updateOnEnter: (e)->
    @close() if e.which is ENTER_KEY
  clear: ->
    @model.destroy()