class GamesController < ApplicationController
	before_action :admin_user, only: [:edit, :update]

	def new
		@game = Game.new
	end

	def show
		@game = Game.find(params[:id])
	end

	def create
		admin_id = current_user.id
		@game = Game.create(game_params.merge(:admin_id => admin_id))
		
		if @game.save
			flash[:success] = "Game created!"
			redirect_to @game
		else
			render 'new'
		end
	end

	def edit
		@game = Game.find(params[:id])
	end

	def update
		@game = Game.find(params[:id])
		if @game.update_attributes(game_params)
			flash[:success] = "Game Updated!"
			redirect_to @game
		else
			render 'edit'
		end
	end

	def index
		@games = Game.paginate(page: params[:page])
	end

	def destroy
		Game.find(params[:id]).destroy
		flash[:success] = "Game deleted"
		redirect_to assassins_url
	end

	def join
		@game = Game.find(params[:id])

		unless @game.players.find_by_id(current_user.id)
			Player.create(game: @game, :assassin => current_user)
		    flash[:success] = "Joined Game!"
		else
			flash[:error] = "Already Joined Game!"
		end
		redirect_to @game
	end

	private
	def game_params
		params.require(:game).permit(:name, :description)
	end

	def admin_user
		@game = Game.find(params[:id])
		redirect_to(root_url) unless current_user?(@game.admin)
	end

end
