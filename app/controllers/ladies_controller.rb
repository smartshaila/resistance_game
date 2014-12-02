class LadiesController < ApplicationController
  before_action :set_lady, only: [:show, :edit, :update, :destroy]

  # GET /ladies
  # GET /ladies.json
  def index
    @ladies = Lady.all
  end

  # GET /ladies/1
  # GET /ladies/1.json
  def show
  end

  # GET /ladies/new
  def new
    @lady = Lady.new
  end

  # GET /ladies/1/edit
  def edit
  end

  # POST /ladies
  # POST /ladies.json
  def create
    @lady = Lady.new(lady_params)

    respond_to do |format|
      if @lady.save
        format.html { redirect_to @lady, notice: 'Lady was successfully created.' }
        format.json { render :show, status: :created, location: @lady }
      else
        format.html { render :new }
        format.json { render json: @lady.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ladies/1
  # PATCH/PUT /ladies/1.json
  def update
    respond_to do |format|
      if @lady.update(lady_params)
        format.html { redirect_to @lady, notice: 'Lady was successfully updated.' }
        format.json { render :show, status: :ok, location: @lady }
      else
        format.html { render :edit }
        format.json { render json: @lady.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ladies/1
  # DELETE /ladies/1.json
  def destroy
    @lady.destroy
    respond_to do |format|
      format.html { redirect_to ladies_url, notice: 'Lady was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lady
      @lady = Lady.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lady_params
      params.require(:lady).permit(:game_id, :mission_number, :source_id, :target_id)
    end
end
