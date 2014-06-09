json.array!(@widgets) do |widget|
  json.extract! widget, :id, :title, :full_path, :book_id
  json.url widget_url(widget, format: :json)
end
