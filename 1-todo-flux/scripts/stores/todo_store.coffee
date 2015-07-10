
TodoDispatcher = require('../dispatcher.coffee')
{EventEmitter} = require('events')

TodoActions = require('../actions/todo_actions.coffee')

List = require('../classes/list.coffee')
Task = require('../classes/task.coffee')

CHANGE_EVENT = 'change'

state =
  lists: []
  listId: null

class TodoStore extends EventEmitter.prototype

  @getLists: ->
    state.lists

  @getSelectedList: ->
    state.listId

  @getState: ->
    state


  @emitChange: ->
    @emit(CHANGE_EVENT)

  @addChangeListener: (cb) ->
    @on(CHANGE_EVENT, cb)

  @removeChangeListener: (cb) ->
    @removeListener(CHANGE_EVENT, cb)


  @_dispatchHandler: (payload) ->
    switch payload.actionType
      when "select-list"
        state.listId = payload.listId

      when "add-list"
        list = new List(payload.listName)
        state.listId = list.id
        state.lists.push list

      when "update-list"
        listIdx = _.findIndex state.lists, (list) ->
          list.id == payload.list.id

        if listIdx >= 0
          state.lists[listIdx].update(payload.list)

      when "remove-list"
        state.lists = _.reject state.lists, (list) ->
          list.id == payload.listId

        if payload.listId == state.listId
          if state.lists.length > 0
            state.listId = state.lists[0].id

      when "add-task"
        listIdx = _.findIndex state.lists, (list) ->
          list.id == state.listId

        if listIdx >= 0
          task = new Task(payload.taskText)
          state.lists[listIdx].tasks.push task


      when "update-task"
        listIdx = _.findIndex state.lists, (list) ->
          list.id == state.listId

        if listIdx >= 0
          taskIdx = _.findIndex state.lists[listIdx].tasks, (task) ->
            task.id == payload.task.id
          state.lists[listIdx].tasks[taskIdx].update(payload.task)
          state.lists[listIdx].update(payload.list)


      when "remove-task"
        listIdx = _.findIndex state.lists, (list) ->
          list.id == state.listId

        if listIdx >= 0
          state.lists[listIdx].tasks =
            _.reject state.lists[listIdx].tasks, (task) ->
              task == payload.taskId
          state.lists[listIdx].update(payload.list)

      when "store-state"
        data = JSON.stringify(state)
        localStorage.setItem('todo-list', data)
        return true

      when "restore-state"
        raw = localStorage.getItem('todo-list')

        if raw
          state = JSON.parse(raw)
          state.lists = state.lists.map (list) ->
            convertedList = List.parse(list)
            convertedList

    TodoStore.emitChange()
    true


  dispatchToken: TodoDispatcher.register(TodoStore._dispatchHandler)


module.exports = TodoStore

