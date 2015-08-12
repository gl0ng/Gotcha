class PlayersController < ApplicationController
	before_action :game_in_progress, only: [:defeat, :vanquish]
	before_action :correct_assassin, only: [:defeat, :vanquish]

	def defeat
		@player = Player.find(params[:id])
		@player.passcode = nil
	end

	def vanquish
		@player = Player.find(params[:id])
		if(player_params[:passcode] == @player.passcode)
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

	def correct_assassin
		@player = Player.find(params[:id])
		@assassin = @player.game.players.find_by(:assassin_id => current_user.id)
		unless @assassin.target_id == @player.id
			redirect_to defeat_player_path(@player.target)
		end
	end

	def game_in_progress
		@player = Player.find(params[:id])
		unless @player.game.status == "In-Progress"
			redirect_to @player.game
		end
	end
end