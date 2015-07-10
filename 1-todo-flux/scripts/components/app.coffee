
{TodoListPicker, TodoListContainer} = require('./todo')
{div} = React.DOM

TodoActions = require('../actions/todo_actions.coffee')

module.exports = React.createFactory React.createClass
  displayName: 'TodoApp'


  getInitialState: ->
    lists: []
    listId: null


  getTodoListById: (todoLists, id) ->
    list = null
    if todoLists.length > 0
      list = _.find todoLists, (list) ->
        list.id == id

    list || {}



  handleTodoStoreChange: ->
    newState = @props.TodoStore.getState()
    @setState newState

    setTimeout (-> TodoActions.store(newState)), 0


  componentDidMount: ->
    @props.TodoStore.addChangeListener @handleTodoStoreChange
    TodoActions.restore()

  componentWillUnmount: ->
    @props.TodoStore.removeChangeListener @handleTodoStoreChange


  render: ->
    {lists, listId} = @state
    todoList = @getTodoListById(lists, listId)

    div {},
      TodoListPicker
        todoLists: lists
        currentTodoListId: listId
        addTodoList: @addTodoList
        setCurrentListId: @setCurrentListId

      TodoListContainer
        todoList: todoList || {tasks: []}
        removeTodoList: @removeTodoList
        addTodoTask: @addTodoTask
        updateTodoTask: @updateTodoTask
        removeTodoTask: @removeTodoTask

