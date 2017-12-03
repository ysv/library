class LibraryRowsController < ApplicationController
  before_action :set_library_row, only: [:show, :edit, :update, :destroy]

  # GET /library_rows
  # GET /library_rows.json
  def index
    @library_rows = LibraryRow.all
  end

  # GET /library_rows/1
  # GET /library_rows/1.json
  def show
  end

  # GET /library_rows/new
  def new
    @library_row = LibraryRow.new
  end

  # GET /library_rows/1/edit
  def edit
  end

  # POST /library_rows
  # POST /library_rows.json
  def create
    @library_row = LibraryRow.new(library_row_params)

    respond_to do |format|
      if @library_row.save
        format.html { redirect_to @library_row, notice: 'Library row was successfully created.' }
        format.json { render :show, status: :created, location: @library_row }
      else
        format.html { render :new }
        format.json { render json: @library_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /library_rows/1
  # PATCH/PUT /library_rows/1.json
  def update
    respond_to do |format|
      if @library_row.update(library_row_params)
        format.html { redirect_to @library_row, notice: 'Library row was successfully updated.' }
        format.json { render :show, status: :ok, location: @library_row }
      else
        format.html { render :edit }
        format.json { render json: @library_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /library_rows/1
  # DELETE /library_rows/1.json
  def destroy
    @library_row.destroy
    respond_to do |format|
      format.html { redirect_to library_rows_url, notice: 'Library row was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_row
      @library_row = LibraryRow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_row_params
      params.require(:library_row).permit(:book_id, :catalog_id, :shel_id)
    end
end
