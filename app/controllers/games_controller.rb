class GamesController < ApplicationController
	before_action :game, only: [:show, :edit, :update, :destroy, :join, :start]
	before_action :admin_user, only: [:edit, :update]

	def show
		@game
	end

	def new
		@game = Game.new
	end

	def create
		@game = Game.create(game_params.merge(:admin_id => current_user.id))
		
		if @game.save
			flash[:success] = "Game created!"
			redirect_to @game
		else
			render 'new'
		end
	end

	def edit
		@game
	end

	def update
		if @game.update_attributes(game_params)
			flash[:success] = "Game Updated!"
			redirect_to @game
		else
			render 'edit'
		end
	end

	def index
		if params[:mode] == "assassin_only"
			@games = Game.all.select do |game|
				game.players.where(assassin_id: current_user.id).count > 0
			end
		else
			@games = Game.all
		end
	end

	def destroy
		@game.destroy
		flash[:success] = "Game deleted"
		redirect_to assassins_url
	end

	def join
		if @game.enrolling
			unless @game.players.find_by(assassin_id: current_user.id)
				Player.create(game: @game, :assassin => current_user)
			    flash[:success] = "Joined Game!"
			else
				flash[:danger] = "Already Joined Game!"
			end
		else
			flash[:danger] = "Game Closed to Enrollment"
		end
		redirect_to @game
	end

	def start
		if @game.enrolling
			if @game.players.count > 1
				@game.start
				flash[:success] = "Game Started!"
			else
				flash[:danger] = "Must Have Two or More Players to Start Game!"
			end
		else
			flash[:danger] = "Game Already Started!"
		end
		redirect_to @game
	end

	private
	def game_params
		params.require(:game).permit(:name, :description, :mode)
	end

	def game
		@game = Game.find(params[:id])
	end

	def admin_user
		redirect_to(root_url) unless current_user?(@game.admin)
	end
end
