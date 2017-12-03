class BooksAuthorsController < ApplicationController
  before_action :set_books_author, only: [:show, :edit, :update, :destroy]

  # GET /books_authors
  # GET /books_authors.json
  def index
    @books_authors = BooksAuthor.all
  end

  # GET /books_authors/1
  # GET /books_authors/1.json
  def show
  end

  # GET /books_authors/new
  def new
    @books_author = BooksAuthor.new
  end

  # GET /books_authors/1/edit
  def edit
  end

  # POST /books_authors
  # POST /books_authors.json
  def create
    @books_author = BooksAuthor.new(books_author_params)

    respond_to do |format|
      if @books_author.save
        format.html { redirect_to @books_author, notice: 'Books author was successfully created.' }
        format.json { render :show, status: :created, location: @books_author }
      else
        format.html { render :new }
        format.json { render json: @books_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books_authors/1
  # PATCH/PUT /books_authors/1.json
  def update
    respond_to do |format|
      if @books_author.update(books_author_params)
        format.html { redirect_to @books_author, notice: 'Books author was successfully updated.' }
        format.json { render :show, status: :ok, location: @books_author }
      else
        format.html { render :edit }
        format.json { render json: @books_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books_authors/1
  # DELETE /books_authors/1.json
  def destroy
    @books_author.destroy
    respond_to do |format|
      format.html { redirect_to books_authors_url, notice: 'Books author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books_author
      @books_author = BooksAuthor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def books_author_params
      params.require(:books_author).permit(:book_id, :author_id)
    end
end
