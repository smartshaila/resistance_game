class TeamVotesController < ApplicationController
  before_action :set_team_vote, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /team_votes
  # GET /team_votes.json
  def index
    @team_votes = TeamVote.all
  end

  # GET /team_votes/1
  # GET /team_votes/1.json
  def show
  end

  # GET /team_votes/new
  def new
    @team_vote = TeamVote.new
    @team_vote.team_id = params[:team_id]
    @team_vote.player_assignment_id = params[:player_assignment_id]
  end

  # GET /team_votes/1/edit
  def edit
  end

  # POST /team_votes
  # POST /team_votes.json
  def create
    @team_vote = TeamVote.create(team_vote_params)

    if @team_vote.team.team_voting_complete? and not @team_vote.team.approved? and @team_vote.mission.teams.size < @team_vote.game.mission_capacities.size
      Team.create(mission: @team_vote.team.mission)
    end

    respond_to do |format|
      if @team_vote.save
        if params.include? :player_assignment_redirect
          format.html { redirect_to({controller: :player_assignments, action: :game_state, id: params[:player_assignment_redirect]}, {notice: 'Team vote was successfully updated.',  flash: {type: 'success'}}) }
        end
        format.html { redirect_to @team_vote, notice: 'Team vote was successfully created.' }
        format.json { render :show, status: :created, location: @team_vote }
      else
        format.html { render :new }
        format.json { render json: @team_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_votes/1
  # PATCH/PUT /team_votes/1.json
  def update
    if params[:approve].nil?
      @team_vote.destroy
      if params.include? :player_assignment_redirect
        format.html { redirect_to({controller: :player_assignments, action: :game_state, id: params[:player_assignment_redirect]}, {notice: 'Team vote was successfully updated.',  flash: {type: 'success'}}) }
      end
      format.html { redirect_to team_votes_url, notice: 'Team vote was successfully destroyed.' }
      format.json { head :no_content }
    end
    respond_to do |format|
      if @team_vote.update(team_vote_params)
        if params.include? :player_assignment_redirect
          format.html { redirect_to({controller: :player_assignments, action: :game_state, id: params[:player_assignment_redirect]}, {notice: 'Team vote was successfully updated.',  flash: {type: 'success'}}) }
        end
        format.html { redirect_to @team_vote, notice: 'Team vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_vote }
      else
        format.html { render :edit }
        format.json { render json: @team_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_votes/1
  # DELETE /team_votes/1.json
  def destroy
    @team_vote.destroy
    respond_to do |format|
      format.html { redirect_to team_votes_url, notice: 'Team vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_vote
      @team_vote = TeamVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_vote_params
      params.require(:team_vote).permit(:approve, :team_id, :player_assignment_id)
    end
end
