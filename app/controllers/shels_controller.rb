class ShelsController < ApplicationController
  before_action :set_shel, only: [:show, :edit, :update, :destroy]

  # GET /shels
  # GET /shels.json
  def index
    @shels = Shel.all
  end

  # GET /shels/1
  # GET /shels/1.json
  def show
  end

  # GET /shels/new
  def new
    @shel = Shel.new
  end

  # GET /shels/1/edit
  def edit
  end

  # POST /shels
  # POST /shels.json
  def create
    @shel = Shel.new(shel_params)

    respond_to do |format|
      if @shel.save
        format.html { redirect_to @shel, notice: 'Shel was successfully created.' }
        format.json { render :show, status: :created, location: @shel }
      else
        format.html { render :new }
        format.json { render json: @shel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shels/1
  # PATCH/PUT /shels/1.json
  def update
    respond_to do |format|
      if @shel.update(shel_params)
        format.html { redirect_to @shel, notice: 'Shel was successfully updated.' }
        format.json { render :show, status: :ok, location: @shel }
      else
        format.html { render :edit }
        format.json { render json: @shel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shels/1
  # DELETE /shels/1.json
  def destroy
    @shel.destroy
    respond_to do |format|
      format.html { redirect_to shels_url, notice: 'Shel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shel
      @shel = Shel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shel_params
      params.require(:shel).permit(:name, :row)
    end
end
