class LancelotsController < ApplicationController
  before_action :set_lancelot, only: [:show, :edit, :update, :destroy]

  # GET /lancelots
  # GET /lancelots.json
  def index
    @lancelots = Lancelot.all
  end

  # GET /lancelots/1
  # GET /lancelots/1.json
  def show
  end

  # GET /lancelots/new
  def new
    @lancelot = Lancelot.new
  end

  # GET /lancelots/1/edit
  def edit
  end

  # POST /lancelots
  # POST /lancelots.json
  def create
    @lancelot = Lancelot.new(lancelot_params)

    respond_to do |format|
      if @lancelot.save
        format.html { redirect_to @lancelot, notice: 'Lancelot was successfully created.' }
        format.json { render :show, status: :created, location: @lancelot }
      else
        format.html { render :new }
        format.json { render json: @lancelot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lancelots/1
  # PATCH/PUT /lancelots/1.json
  def update
    respond_to do |format|
      if @lancelot.update(lancelot_params)
        format.html { redirect_to @lancelot, notice: 'Lancelot was successfully updated.' }
        format.json { render :show, status: :ok, location: @lancelot }
      else
        format.html { render :edit }
        format.json { render json: @lancelot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lancelots/1
  # DELETE /lancelots/1.json
  def destroy
    @lancelot.destroy
    respond_to do |format|
      format.html { redirect_to lancelots_url, notice: 'Lancelot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lancelot
      @lancelot = Lancelot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lancelot_params
      params.require(:lancelot).permit(:switched, :mission_id)
    end
end
