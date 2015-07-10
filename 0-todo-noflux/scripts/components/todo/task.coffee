
{li, input, a, div} = React.DOM

Task = require('./task.coffee')

module.exports = React.createFactory React.createClass
  displayName: 'TodoTask'


  toggleTaskCompleted: (e) ->
    {task} = @props
    if e.target.checked == true
      task.completedAt = new Date()
    else
      task.completedAt = null

    @props.updateTask(task)


  changeTaskNameKeyUp: (e) ->
    if e.keyCode == 13
      {task} = @props
      task.name = e.target.value
      @props.updateTask(task)


  removeTask: (e) ->
    e.preventDefault()
    allowRemoval = confirm('Are you sure you want to delete this task?')
    @props.removeTask(@props.task.id) if allowRemoval



  render: ->
    {task} = @props

    isCompleted = !!task.completedAt

    bem = new Bemmer(block: 'todo-task')

    li className: bem.with(element: 'item'),
      input
        className: bem.with(element: 'item-complete')
        type: 'checkbox'
        onChange: @toggleTaskCompleted
        checked: isCompleted

      input
        className: bem.with(
          element: 'item-text'
          modifiers: {completed: isCompleted}
        )
        readOnly: isCompleted
        defaultValue: task.text
        onKeyUp: @changeTaskNameKeyUp

      a
        className: bem.with(element: 'item-remove')
        href: '#delete-task'
        onClick: @removeTask
        dangerouslySetInnerHTML:
          __html: "&times;"


      if isCompleted
        completionTimeMS =
          task.completedAt.getTime() - task.createdAt.getTime()
        minutes = Math.round(completionTimeMS / 1000 / 60)
        minutes = "less than 1" if minutes < 1

        div className: bem.with(element: 'item-summary'),
          "Task took #{minutes} minute(s)"


