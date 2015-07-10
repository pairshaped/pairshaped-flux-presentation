
module.exports = class Task
  @parse: (jsonObject) ->
    task = new Task(jsonObject.text)
    task.id = jsonObject.id
    task.createdAt = new Date(jsonObject.createdAt)
    if jsonObject.completedAt
      task.completedAt = new Date(jsonObject.completedAt)
    task

  constructor: (@text) ->
    @id = uuid.v4()
    @createdAt = new Date()
    @completedAt = null


  update: (obj) ->
    for field in ['text', 'completedAt']
      if _.has(obj, field)
        @[field] = obj[field]
