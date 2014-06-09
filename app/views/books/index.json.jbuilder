json.array!(@books) do |book|
  json.extract! book, :id, :title, :book_template
  json.url book_url(book, format: :json)
end
