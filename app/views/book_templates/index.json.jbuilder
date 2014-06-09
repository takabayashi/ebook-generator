json.array!(@book_templates) do |book_template|
  json.extract! book_template, :id, :title
  json.url book_template_url(book_template, format: :json)
end
