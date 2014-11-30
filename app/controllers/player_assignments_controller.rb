class PlayerAssignmentsController < ApplicationController
  before_action :set_player_assignment, only: [:show, :edit, :update, :destroy, :revealed_info, :game_state, :current_action, :game_log, :assassinate]
  layout 'logged_in'

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

  def revealed_info
  end

  def assassinate
    aa = params[:hit_list].first
    unless aa.nil?
      @player_assignment.game.update(assassinated_assignment_id: aa.to_i)
    end
    if params.include? :player_assignment_redirect
      redirect_to({controller: :player_assignments, action: :game_state, id: params[:player_assignment_redirect]}, {notice: "Assassination completed", flash: {type: 'success'}})
    end
  end

  def game_state
    @waiting_players = []
    @mission_status_text = ''
  end

  def current_action
    is_king = @player_assignment == @player_assignment.game.current_king
    is_questing = @player_assignment.game.current_team.team_assignments.any? {|assignment| assignment.player_assignment == @player_assignment}
    team_assigned = @player_assignment.game.current_team.assignments_complete?
    voting_complete = @player_assignment.game.current_team.team_voting_complete?
    mission_complete = @player_assignment.game.current_team.mission_voting_complete?

    @renders = {}
    @renders[:team_assignments] = (is_king and not voting_complete)
    @renders[:team_votes] = (team_assigned and not voting_complete)
    @renders[:mission_votes] = (team_assigned and voting_complete and is_questing and not mission_complete)

    if @renders[:team_assignments]
      @team = @player_assignment.game.current_team
    end

    current_team_current_player = {team: @player_assignment.game.current_team, player_assignment: @player_assignment}

    if @renders[:team_votes]
      # In Ruby, a || b defers to b if a is nil
      @team_vote = (TeamVote.where(current_team_current_player).first or TeamVote.new(current_team_current_player))
    end

    if @renders[:mission_votes]
      @team_assignment = (TeamAssignment.where(current_team_current_player).first or TeamAssignment.new(current_team_current_player))
      logger.info @team_assignment
    end

   end

  def game_log
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
