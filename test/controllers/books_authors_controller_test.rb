require 'test_helper'

class BooksAuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @books_author = books_authors(:one)
  end

  test "should get index" do
    get books_authors_url
    assert_response :success
  end

  test "should get new" do
    get new_books_author_url
    assert_response :success
  end

  test "should create books_author" do
    assert_difference('BooksAuthor.count') do
      post books_authors_url, params: { books_author: { author_id: @books_author.author_id, book_id: @books_author.book_id } }
    end

    assert_redirected_to books_author_url(BooksAuthor.last)
  end

  test "should show books_author" do
    get books_author_url(@books_author)
    assert_response :success
  end

  test "should get edit" do
    get edit_books_author_url(@books_author)
    assert_response :success
  end

  test "should update books_author" do
    patch books_author_url(@books_author), params: { books_author: { author_id: @books_author.author_id, book_id: @books_author.book_id } }
    assert_redirected_to books_author_url(@books_author)
  end

  test "should destroy books_author" do
    assert_difference('BooksAuthor.count', -1) do
      delete books_author_url(@books_author)
    end

    assert_redirected_to books_authors_url
  end
end
