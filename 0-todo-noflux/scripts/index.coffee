require '../styles/index'

TodoApp = require './todo_app.coffee'

document.addEventListener 'DOMContentLoaded', (e) ->
  React.render(
    TodoApp(null)
    document.body
  )

