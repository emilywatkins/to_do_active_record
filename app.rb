require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/task")
require("./lib/list")
require("pg")

get('/') do
  @tasks = Task.all
  erb(:index)
end

post('/tasks') do
  description = params['description']
  task = Task.new({:description => description})
  task.save
  erb(:success)
end

get('/tasks/:id/edit') do
  @task = Task.find(params['id'].to_i)
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params['description']
  @task = Task.find(params['id'].to_i)
  @task.update({:description => description})
  @tasks = Task.all
  erb(:index)
end
