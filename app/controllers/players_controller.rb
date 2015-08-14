class PlayersController < ApplicationController
	before_action :player 
	before_action :assassin
	before_action :game_in_progress
	before_action :correct_assassin

	def defeat
		@player.passcode = nil
	end

	def vanquish

		if(player_params[:passcode] == @player.passcode)
			player.vanquished(assassin)
			flash[:success] = "Congradulations, Player Defeated!"
			redirect_to @player.game
		else
			flash[:danger] = "Wrong Passcode!"
			redirect_to defeat_player_path(@player)
		end
	end

	private

	def player_params
		params.require(:player).permit(:passcode)
	end

	def player
		@player = Player.find(params[:id])
	end

	def assassin
		@assassin = @player.game.players.find_by(:assassin_id => current_user.id)
	end

	def correct_assassin
		unless @assassin.target_id == @player.id
			redirect_to defeat_player_path(Player.find(@player.target_id))
		end
	end

	def game_in_progress
		unless @player.game.in_progress
			redirect_to @player.game
		end
	end
end