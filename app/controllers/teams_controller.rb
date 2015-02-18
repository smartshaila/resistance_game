class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit

  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    notice = 'Team has not been changed yet'
    type = 'warning'
    assigned_players = (params[:team][:team_assignments] or [])
    if @team.team_voting_complete?
      notice = 'Team voting is already complete'
      type = 'danger'
    elsif assigned_players.size > @team.mission.capacity.capacity
      notice = 'You have selected too many people for this team'
      type = 'danger'
    else
      @team.team_assignments.destroy_all
      @team.team_votes.destroy_all
      assigned_players.each do |pa|
        TeamAssignment.create(team: @team, player_assignment_id: pa.to_i)
      end
      notice = 'Team was successfully updated' if @team.update(team_params)
      type = 'success'
    end

    respond_to do |format|
      if params.include? :player_assignment_redirect
          format.html { redirect_to({controller: :player_assignments, action: :current_action, id: params[:player_assignment_redirect]}, {notice: notice, flash: {type: type}}) }
      else
        format.html { render :edit, notice: notice }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:mission_id)
    end
end
