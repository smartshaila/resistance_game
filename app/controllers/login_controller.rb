class LoginController < ApplicationController
  def index
    @players = Player.all
  end

  def login
    p = params[:player_id]
    if p.empty?
      redirect_to action: :index
    else
      player = Player.find(p)
      if player.calculate_password_hash(params[:password]) == player.password_hash
        redirect_to controller: :players, action: :current_games, id: p
      else
        redirect_to action: :index
      end
    end
  end
end
