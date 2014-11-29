class LoginController < ApplicationController
  def index
    @games = Game.all.find_all {|g| !g.complete?}
    @player_assignment_json = Game.all.map{|g| {g.id => g.player_assignments.map{|p| {id: p.id, name: p.player.name}}}}.inject({}){|a,b| a.merge(b)}.to_json
  end

  def login
    pa = params[:player_assignment_id]
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
