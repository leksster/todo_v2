json.merge! project.attributes
json.tasks project.tasks, partial: 'api/tasks/task', as: :task
json.owner project.user.email