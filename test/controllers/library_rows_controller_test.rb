require 'test_helper'

class LibraryRowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @library_row = library_rows(:one)
  end

  test "should get index" do
    get library_rows_url
    assert_response :success
  end

  test "should get new" do
    get new_library_row_url
    assert_response :success
  end

  test "should create library_row" do
    assert_difference('LibraryRow.count') do
      post library_rows_url, params: { library_row: { book_id: @library_row.book_id, catalog_id: @library_row.catalog_id, shel_id: @library_row.shel_id } }
    end

    assert_redirected_to library_row_url(LibraryRow.last)
  end

  test "should show library_row" do
    get library_row_url(@library_row)
    assert_response :success
  end

  test "should get edit" do
    get edit_library_row_url(@library_row)
    assert_response :success
  end

  test "should update library_row" do
    patch library_row_url(@library_row), params: { library_row: { book_id: @library_row.book_id, catalog_id: @library_row.catalog_id, shel_id: @library_row.shel_id } }
    assert_redirected_to library_row_url(@library_row)
  end

  test "should destroy library_row" do
    assert_difference('LibraryRow.count', -1) do
      delete library_row_url(@library_row)
    end

    assert_redirected_to library_rows_url
  end
end
