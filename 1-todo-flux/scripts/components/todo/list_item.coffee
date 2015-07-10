{li} = React.DOM

TodoStore = require('../../actions/todo_actions.coffee')

module.exports = React.createFactory React.createClass
  displayName: 'TodoListItem'


  setTodoList: (e) ->
    e.preventDefault()
    TodoStore.selectTodoList(@props.todoList.id)


  render: ->
    {todoList} = @props

    bem = new Bemmer(block: 'todo-list-item')

    tasksCompleted = _.select todoList.tasks, (task) ->
      task.completedAt != null
    completedText =  "#{tasksCompleted.length}/#{todoList.tasks.length}"

    li
      className: bem.with(
        element: 'text'
        modifiers: {active: @props.isActive}
      )
      onClick: @setTodoList

      "#{@props.todoList.name} (#{completedText})"
