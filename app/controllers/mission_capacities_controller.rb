class MissionCapacitiesController < ApplicationController
  before_action :set_mission_capacity, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /mission_capacities
  # GET /mission_capacities.json
  def index
    @mission_capacities = MissionCapacity.all
  end

  # GET /mission_capacities/1
  # GET /mission_capacities/1.json
  def show
  end

  # GET /mission_capacities/new
  def new
    @mission_capacity = MissionCapacity.new
  end

  # GET /mission_capacities/1/edit
  def edit
  end

  # POST /mission_capacities
  # POST /mission_capacities.json
  def create
    @mission_capacity = MissionCapacity.new(mission_capacity_params)

    respond_to do |format|
      if @mission_capacity.save
        format.html { redirect_to @mission_capacity, notice: 'Mission capacity was successfully created.' }
        format.json { render :show, status: :created, location: @mission_capacity }
      else
        format.html { render :new }
        format.json { render json: @mission_capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mission_capacities/1
  # PATCH/PUT /mission_capacities/1.json
  def update
    respond_to do |format|
      if @mission_capacity.update(mission_capacity_params)
        format.html { redirect_to @mission_capacity, notice: 'Mission capacity was successfully updated.' }
        format.json { render :show, status: :ok, location: @mission_capacity }
      else
        format.html { render :edit }
        format.json { render json: @mission_capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_capacities/1
  # DELETE /mission_capacities/1.json
  def destroy
    @mission_capacity.destroy
    respond_to do |format|
      format.html { redirect_to mission_capacities_url, notice: 'Mission capacity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission_capacity
      @mission_capacity = MissionCapacity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_capacity_params
      params.require(:mission_capacity).permit(:player_count, :mission_number, :capacity, :fail_count)
    end
end
