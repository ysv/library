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
    @catalogs = Catalog.find_by_sql("
    SELECT *
    FROM catalogs
    INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id
    WHERE library_rows.book_id = 1;
    ")
  end

  def query2
    @shels = Shel.find_by_sql("
    SELECT shels.name
    FROM ((shels
    INNER JOIN library_rows ON shels.id = library_rows.shel_id)
    INNER JOIN catalogs ON library_rows.catalog_id = catalogs.id)
    WHERE catalogs.name = 'History' AND catalogs.characteristic = 'top5'  ;
    ")
  end

  def query3
    @books = Book.find_by_sql("
    SELECT books.title, authors.name
    FROM (((( books
    INNER JOIN library_rows ON books.id = library_rows.book_id)
    INNER JOIN shels ON library_rows.shel_id = shels.id)
    INNER JOIN books_authors ON books.id = books_authors.book_id)
    INNER JOIN authors ON books_authors.author_id = authors.id)
    WHERE shels.row >= 2;
    ")
  end

  def query4
    @books = Book.find_by_sql("
    SELECT books.*
    FROM ((books
    INNER JOIN books_authors ON books.id = books_authors.book_id)
    INNER JOIN authors ON books_authors.author_id = authors.id)
    WHERE books.date <= '2017-01-01';
    ")
  end

  def query5
    @catalogs = Catalog.find_by_sql("
    SELECT catalogs.*
    FROM (( catalogs
    INNER JOIN library_rows ON catalogs.id = library_rows.catalog_id)
    INNER JOIN books ON library_rows.book_id = books.id)
    WHERE books.id IN(
                        SELECT books.id
                        FROM books
                        WHERE books.date < '2017-01-01' OR books.date > '2017-12-31'
                    );
  ")
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
