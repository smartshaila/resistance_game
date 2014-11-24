class LoginController < ApplicationController
  def index
    @games = Game.all
  end

  def login
    pa = params[:player_assignment_id].first
    unless pa.empty?
      player_assignment = PlayerAssignment.find(pa)
      player = player_assignment.player
      if player.calculate_password_hash(params[:password]) == player.password_hash
        redirect_to controller: :player_assignments, action: :game_state, id: pa
      else
        redirect_to action: :index
      end
    else
      redirect_to action: :index
    end
  end
end
