{ul, li, input} = React.DOM

ListItem = require('./list_item.coffee')

module.exports = React.createFactory React.createClass
  displayName: 'TodoListPicker'


  handleCreateTodoListInputKeyUp: (e) ->
    if e.keyCode == 13
      @props.addTodoList(e.target.value)
      e.target.value = ''


  render: ->
    bem = new Bemmer(block: 'todo-list-picker')

    ul className: bem.with(element: 'container'),
      li className: bem.with(element: 'container-new'),
        input
          className: bem.with(element: 'container-new-input')
          placeholder: 'Create a new todo list...'
          onKeyUp: @handleCreateTodoListInputKeyUp

      @props.todoLists.map (todoList) =>
        ListItem
          key: todoList.id
          todoList: todoList
          isActive: todoList.id == @props.currentTodoListId
          setCurrentListId: @props.setCurrentListId

