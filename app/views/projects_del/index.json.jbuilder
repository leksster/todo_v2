json.array!(@projects) do |project|
  json.extract! project, :id, :name, :tasks
  json.url project_url(project, format: :json)
end