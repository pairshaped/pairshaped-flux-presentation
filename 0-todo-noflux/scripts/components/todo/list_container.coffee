
{div, h1, a, ol, li, input} = React.DOM

Task = require('./task.coffee')

module.exports = React.createFactory React.createClass
  displayName: 'TodoListContainer'

  removeList: (e) ->
    e.preventDefault()
    allowListRemoval = confirm(
      "Are you sure you want to delete #{@props.todoList.name} todo list?"
    )

    @props.removeTodoList(@props.todoList.id) if allowListRemoval


  addTask: (e) ->
    if e.keyCode == 13
      @props.addTodoTask(@props.todoList.id, e.target.value)
      e.target.value = ""


  updateTask: (task) ->
    @props.updateTodoTask(@props.todoList.id, task)


  removeTask: (taskId) ->
    @props.removeTodoTask(@props.todoList.id, taskId)


  render: ->
    {todoList} = @props

    bem = new Bemmer(block: 'todo-container')

    div className: bem.with(element: 'container'),
      h1 className: bem.with(element: 'container-header'),
        todoList.name

      if todoList.id
        a
          className: bem.with(element: 'container-delete-list')
          href: '#delete-list'
          onClick: @removeList

          'Delete List'

      if todoList.id
        ol className: bem.with(element: 'container-task-list'),
          todoList.tasks.map (task) =>
            Task
              key: task.id
              task: task
              updateTask: @updateTask
              removeTask: @removeTask

          li className: bem.with(element: 'container-task-list-new'),
            input
              className: bem.with(element: 'container-task-list-new-input')
              placeholder: 'New task name...'
              onKeyUp: @addTask


