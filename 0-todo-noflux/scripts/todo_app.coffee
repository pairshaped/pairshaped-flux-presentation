
{TodoListPicker, TodoListContainer} = require('./components/todo')
{div} = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'TodoApp'


  getInitialState: ->
    todoLists: []
    currentTodoListId: null


  warn: ->
    args = Array.prototype.slice.call(arguments)
    console.error.apply(args)
    alert.apply(args[0])


  addTodoList: (name) ->
    if name.length < 1
      @warn "You can't create a list without a name!",
        args: arguments
        state: @state
      return

    list =
      id: uuid.v4()
      name: name
      tasks: []
      createdAt: new Date()

    @setState {todoLists: @state.todoLists.concat(list)}, =>
      @setCurrentListId(list.id)
      @storeState(@state)


  removeTodoList: (todoListId) ->
    {todoLists} = @state

    todoLists = _.reject todoLists, (list) ->
      list.id == todoListId

    @setState todoLists: todoLists


  updateTodoList: (list) ->
    {todoLists} = @state

    listIdx = _.findIndex todoLists, (todoList) ->
      list.id == todoList.id

    todoLists[listIdx] = list

    state = @state
    state.todoLists = todoLists

    console.log 'updateTodoList', list, state
    @storeState(state)

    @setState state

  getTodoListById: (id) ->
    _.find @state.todoLists, (list) ->
      list.id == id


  setCurrentListId: (id) ->
    todoList = _.find @state.todoLists, (list) ->
      list.id == id
    if todoList
      state = @state
      state.currentTodoListId = id
      @storeState(state)
      @setState state


  addTodoTask: (todoListId, taskText) ->
    todoList = @getTodoListById(todoListId)

    console.log 'addTodoTask', arguments
    console.debug todoList

    unless todoList
      @warn "List does not exist!",
        method: 'addTodoTask', state: @state, args: arguments

      return

    todoList.tasks.push
      id: uuid.v4()
      text: taskText
      completedAt: null
      createdAt: new Date()

    @updateTodoList(todoList)


  updateTodoTask: (todoListId, task) ->
    list = @getTodoListById(todoListId)

    unless list
      @warn "List does not exist!",
        method: 'updateTodoTask',
          state: @state, args: arguments
      return

    taskIdx = _.indexOf list.tasks, (listTask) ->
      task.id == listTask.id

    list.tasks[taskIdx] = task

    @updateTodoList(list)


  removeTodoTask: (todoListId, taskId) ->
    list = @getTodoListById(todoListId)

    unless list
      @warn "List does not exist!",
        method: 'removeTodoTask',
          state: @state, args: arguments
      return

    list.tasks = _.reject list.tasks, (task) ->
      taskId == task.id

    @updateTodoList(list)


  storeState: (state) ->
    console.log 'storing', state
    data = JSON.stringify(state)
    localStorage.setItem('todo-list', data)


  restoreState: (warningMessage = '') ->
    raw = localStorage.getItem('todo-list')

    unless raw
      @warn warningMesage if warningMessage
      return

    data = JSON.parse(raw)

    data.todoLists = _.map data.todoLists, (list) ->
      list.createdAt = new Date(list.createdAt)
      list.tasks = list.tasks.map (task) ->
        task.createdAt = new Date(task.createdAt)
        task.completedAt = new Date(task.completedAt) if task.completedAt
        task
      list

    console.log 'data', data

    @setState data


  componentDidMount: ->
    @restoreState()

  render: ->
    todoList = @getTodoListById(@state.currentTodoListId)

    div {},
      TodoListPicker
        todoLists: @state.todoLists
        currentTodoListId: @state.currentTodoListId
        addTodoList: @addTodoList
        setCurrentListId: @setCurrentListId

      TodoListContainer
        todoList: todoList || {tasks: []}
        removeTodoList: @removeTodoList
        addTodoTask: @addTodoTask
        updateTodoTask: @updateTodoTask
        removeTodoTask: @removeTodoTask

