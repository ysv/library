json.extract! books_author, :id, :book_id, :author_id, :created_at, :updated_at
json.url books_author_url(books_author, format: :json)
