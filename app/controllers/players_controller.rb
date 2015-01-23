class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :current_games, :archived_games, :graphs]
  layout 'player'

  # GET /players
  # GET /players.json

  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    @player.password_salt = generate_salt
    @player.password_hash = @player.calculate_password_hash(params[:password])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    @player.password_salt = generate_salt
    @player.password_hash = @player.calculate_password_hash(params[:password])

    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_games
    @available_assignments = @player.player_assignments.select{|pa| !pa.game.complete?}
  end

  def archived_games
    @archived_games = @player.player_assignments.select{|pa| pa.game.complete?}.map{|pa| pa.game}
  end

  def graphs
    @completed_games = Game.all.select{|g| g.complete?}
    @games_by_date = @completed_games.group_by{|game|
      game.created_at.to_date
    }.map{|d,g|
      [d, g.count]
    }
  end

  def join_game
    pa = params[:player_assignment_id]

    if pa.empty?
      redirect_to action: :current_games
    else
      redirect_to controller: :player_assignments, action: :game_state, id: pa
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :password)
    end

    def generate_salt
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
      # return salt
      (0...50).map{o[rand(o.length)]}.join
    end
end
