class TeamAssignmentsController < ApplicationController
  before_action :set_team_assignment, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /team_assignments
  # GET /team_assignments.json
  def index
    @team_assignments = TeamAssignment.all
  end

  # GET /team_assignments/1
  # GET /team_assignments/1.json
  def show
  end

  # GET /team_assignments/new
  def new
    @team_assignment = TeamAssignment.new
  end

  # GET /team_assignments/1/edit
  def edit
  end

  # POST /team_assignments
  # POST /team_assignments.json
  def create
    @team_assignment = TeamAssignment.new(team_assignment_params)

    respond_to do |format|
      if @team_assignment.save
        format.html { redirect_to @team_assignment, notice: 'Team assignment was successfully created.' }
        format.json { render :show, status: :created, location: @team_assignment }
      else
        format.html { render :new }
        format.json { render json: @team_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_assignments/1
  # PATCH/PUT /team_assignments/1.json
  def update
    team_assignment_updated = @team_assignment.update(team_assignment_params)

    if @team_assignment.team.mission_voting_complete?
      @team_assignment.team.mission.game.increment_mission
    end

    respond_to do |format|
      if team_assignment_updated
        if params.include? :player_assignment_redirect
          format.html { redirect_to({controller: :player_assignments, action: :game_state, id: params[:player_assignment_redirect]}, {notice: 'Mission vote was successfully updated.', flash: {type: 'success'}}) }
        end
        format.html { redirect_to @team_assignment, notice: 'Team assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_assignment }
      else
        format.html { render :edit }
        format.json { render json: @team_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_assignments/1
  # DELETE /team_assignments/1.json
  def destroy
    @team_assignment.destroy
    respond_to do |format|
      format.html { redirect_to team_assignments_url, notice: 'Team assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_assignment
      @team_assignment = TeamAssignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_assignment_params
      params.require(:team_assignment).permit(:pass, :team_id, :player_assignment_id)
    end
end
