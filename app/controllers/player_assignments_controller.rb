class PlayerAssignmentsController < ApplicationController
  before_action :set_player_assignment, only: [:show, :edit, :update, :destroy, :revealed_info, :game_state, :current_action, :game_log, :assassinate, :update_status]
  layout 'game'

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
    @revealed = @player_assignment.game.ladies.select{|l| l.source == @player_assignment and not l.target.nil?}.map{|lady|
      {
        player: lady.target.player,
        faction: lady.target.role.faction
      }
    }
    players = @revealed.map{|r| r[:player]}
    @revealed += (@player_assignment.visible_relationships.select{|hash| !players.include? hash[:player]})
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
    @current_hash = game_state_hash_code
  end

  def current_action
    state = game_state_hash
    @renders = {}
    @renders[:ladies] = (state[:is_lady] and not state[:team_assigned] and not state[:lady_complete])
    @renders[:team_assignments] = (state[:is_king] and state[:lady_complete] and not state[:voting_complete])
    @renders[:team_votes] = (state[:team_assigned] and not state[:voting_complete])
    @renders[:mission_votes] = (state[:team_assigned] and state[:voting_complete] and state[:is_questing] and not state[:mission_complete])

    if @renders[:ladies]
      @lady = @player_assignment.game.current_lady
    end

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
    end

   end

  def game_log
    @current_hash = game_state_hash_code
  end

  def update_status
    new_hash = game_state_hash_code
    res = (params[:current_hash_code] != game_state_hash_code) ? {hash_code: new_hash, redirect: current_action_player_assignment_path(@player_assignment)} : {hash_code: new_hash}
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

    def game_state_hash
      is_king = @player_assignment == @player_assignment.game.current_king
      is_questing = @player_assignment.game.current_team.team_assignments.any? {|assignment| assignment.player_assignment == @player_assignment}
      current_lady = @player_assignment.game.current_mission.lady
      is_lady = (!current_lady.nil? and @player_assignment == current_lady.source)
      lady_complete = (current_lady.nil? or !current_lady.target.nil?)
      team_assigned = @player_assignment.game.current_team.assignments_complete?
      voting_complete = @player_assignment.game.current_team.team_voting_complete?
      mission_complete = @player_assignment.game.current_team.mission_voting_complete?
      {is_king: is_king, is_questing: is_questing, is_lady: is_lady, lady_complete: lady_complete, team_assigned: team_assigned, voting_complete: voting_complete, mission_complete: mission_complete}
    end

    def game_state_hash_code
      gs = game_state_hash
      hash_code = 0
      gs.keys.sort.each_with_index{|key, index| hash_code += ((1 << index) * (gs[key] ? 1 : 0))}
    end
end
