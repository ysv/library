class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create

    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def home
    @books = Book.all
    @authors = Author.all
    @catalogs = Catalog.all
    @shels = Shel.all
    @library_rows = LibraryRow.all
    @books_authors = BooksAuthor.all
  end

  def query1
    @catalogs = []
    book_id = params[:book][:id]
    @catalogs = Catalog.find_by_sql("
    SELECT *
    FROM catalogs
    INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id
    WHERE library_rows.book_id = #{book_id};
    ") if !params[:book][:id].empty?
  end

  def query2
    @shels = []
    characteristic = params[:catalog][:characteristic]
    @shels = Shel.find_by_sql("
    SELECT shels.name
    FROM ((shels
    INNER JOIN library_rows ON shels.id = library_rows.shel_id)
    INNER JOIN catalogs ON library_rows.catalog_id = catalogs.id)
    WHERE catalogs.name = 'History' AND catalogs.characteristic = \"#{characteristic}\"  ;
    ") if !params[:catalog][:characteristic].empty?
  end

  def query3
    @books = []
    row = params[:shel][:row]
    @books = Book.find_by_sql("
    SELECT books.title, authors.name
    FROM (((( books
    INNER JOIN library_rows ON books.id = library_rows.book_id)
    INNER JOIN shels ON library_rows.shel_id = shels.id)
    INNER JOIN books_authors ON books.id = books_authors.book_id)
    INNER JOIN authors ON books_authors.author_id = authors.id)
    WHERE shels.row >= #{row};
    ") if !params[:shel][:row].empty?
  end

  def query4
    @books = []
    author_name = params[:author][:name]
    book_year = params[:book][:year]
    @books = Book.find_by_sql("
    SELECT books.*
    FROM ((books
    INNER JOIN books_authors ON books.id = books_authors.book_id)
    INNER JOIN authors ON books_authors.author_id = authors.id)
    WHERE books.date <= '#{book_year}' AND authors.name = '#{author_name}';
    ") if !params[:author][:name].empty? && !params[:book][:year].empty?
  end

  def query5
    @catalogs = []
    book_year = params[:book][:year]
    @catalogs = Catalog.find_by_sql("
    SELECT catalogs.*
    FROM (( catalogs
    INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id)
    INNER JOIN books ON library_rows.book_id = books.id)
    WHERE books.id NOT IN(
                        SELECT books.id
                        FROM books
                        WHERE books.date >= '#{book_year}-01-01' AND books.date <= '#{book_year}-12-31'
                    );
  ") if !params[:book][:year].empty?
  end

  def query6
    @authors = []
    catalog_id = params[:catalog][:id]
    @authors = Author.find_by_sql("
    SELECT authors.*
    FROM authors
    INNER JOIN books_authors ON authors.id = books_authors.author_id
    GROUP BY authors.id
    HAVING COUNT(books_authors.book_id) <= (
                                            SELECT COUNT(books.id)
                                            FROM (( books
                                            INNER JOIN library_rows ON books.id = library_rows.book_id)
                                            INNER JOIN catalogs ON library_rows.catalog_id = catalogs.id)
                                            WHERE catalogs.id = #{catalog_id}
                                            );
    ") if !params[:catalog][:id].empty?
  end

  def query7
    @catalogs = Catalog.find_by_sql("
    SELECT c1.*
    FROM catalogs AS c1
    WHERE EXISTS (
        SELECT catalogs.id
        FROM ((catalogs
        INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id)
        INNER JOIN books ON library_rows.book_id = books.id)
        WHERE catalogs.id = c1.id AND books.id NOT IN (
            SELECT books.id
            FROM ((catalogs
            INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id)
            INNER JOIN books ON library_rows.book_id = books.id)
            WHERE catalogs.id != c1.id));
    ")
  end

  def query8

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :date, :pages)
    end
end
