Task = require('./task')

module.exports = class List
  @parse: (jsonObject) ->
    list = new List(jsonObject.name)
    list.id = jsonObject.id
    list.tasks = jsonObject.tasks.map (task) ->
      Task.parse(task)
    list.createdAt = new Date(jsonObject.createdAt)
    list

  constructor: (@name) ->
    @id = uuid.v4()
    @tasks = []
    @createdAt = new Date()

  update: (obj) ->
    for field in ['name', 'tasks']
      if _.has(obj, field)
        @[field] = obj[field]

  addTask: (text) ->
    @tasks.push(new Task(text))

  updateTask: (task) ->
    idx = _.findIndex @tasks, (t) -> t.id == task.id
    @tasks[idx] == task

  removeTask: (task) ->
    @tasks = _.reject @tasks, (t) -> t.id == task.id

