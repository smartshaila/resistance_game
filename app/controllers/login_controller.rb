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
        # Reveal Assignment Page
        # format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        logger.info "You win!"
      else
        logger.info "You suck."
      end
    else
      logger.info "Pick a Player silly."
    end
  end
end
