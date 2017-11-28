json.extract! book, :id, :title, :date, :pages, :created_at, :updated_at
json.url book_url(book, format: :json)
