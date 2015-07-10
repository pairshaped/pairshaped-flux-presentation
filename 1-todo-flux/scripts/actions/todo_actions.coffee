
TodoDispatcher = require('../dispatcher.coffee')

module.exports =
  selectTodoList: (listId) ->
    TodoDispatcher.dispatch
      actionType: 'select-list'
      listId: listId


  addTodoList: (name) ->
    TodoDispatcher.dispatch
      actionType: 'add-list'
      listName: name


  updateTodoList: (list) ->
    TodoDispatcher.dispatch
      actionType: 'update-list'
      list: list


  removeTodoList: (todoListId) ->
    TodoDispatcher.dispatch
      actionType: 'remove-list'
      listId: todoListId


  addTodoTask: (taskText) ->
    TodoDispatcher.dispatch
      actionType: 'add-task'
      taskText: taskText


  updateTodoTask: (task) ->
    TodoDispatcher.dispatch
      actionType: 'update-task'
      task: task


  removeTodoTask: (taskId) ->
    TodoDispatcher.dispatch
      actionType: 'remove-task'
      taskId: taskId


  store: (state) ->
    TodoDispatcher.dispatch
      actionType: 'store-state'
      state: state


  restore: ->
    TodoDispatcher.dispatch
      actionType: 'restore-state'

