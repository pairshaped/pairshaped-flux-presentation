require '../styles/index'

TodoApp = require './components/app.coffee'

document.addEventListener 'DOMContentLoaded', (e) ->
  React.render(
    TodoApp(
      TodoStore: require('./stores/todo_store.coffee')
    )
    document.body
  )

