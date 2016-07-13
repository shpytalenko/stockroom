json.array!(@targets) do |target|
  json.extract! target, :id, :name
  json.url target_url(target, format: :json)
end
