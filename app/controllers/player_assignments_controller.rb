class PlayerAssignmentsController < ApplicationController
  before_action :set_player_assignment, only: [:show, :edit, :update, :destroy]

  # GET /player_assignments
  # GET /player_assignments.json
  def index
    @player_assignments = PlayerAssignment.all
  end

  # GET /player_assignments/1
  # GET /player_assignments/1.json
  def show
  end

  # GET /player_assignments/new
  def new
    @player_assignment = PlayerAssignment.new
  end

  # GET /player_assignments/1/edit
  def edit
  end

  # POST /player_assignments
  # POST /player_assignments.json
  def create
    @player_assignment = PlayerAssignment.new(player_assignment_params)

    respond_to do |format|
      if @player_assignment.save
        format.html { redirect_to @player_assignment, notice: 'Player assignment was successfully created.' }
        format.json { render :show, status: :created, location: @player_assignment }
      else
        format.html { render :new }
        format.json { render json: @player_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_assignments/1
  # PATCH/PUT /player_assignments/1.json
  def update
    respond_to do |format|
      if @player_assignment.update(player_assignment_params)
        format.html { redirect_to @player_assignment, notice: 'Player assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_assignment }
      else
        format.html { render :edit }
        format.json { render json: @player_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_assignments/1
  # DELETE /player_assignments/1.json
  def destroy
    @player_assignment.destroy
    respond_to do |format|
      format.html { redirect_to player_assignments_url, notice: 'Player assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_assignment
      @player_assignment = PlayerAssignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_assignment_params
      params.require(:player_assignment).permit(:seat_number, :game_id, :player_id, :role_id)
    end
end
