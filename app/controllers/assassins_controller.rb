class AssassinsController < ApplicationController

	def new
		@assassin = Assassin.new
	end

	def show
		@assassin = Assassin.find(params[:id])
	end

	def create
		@assassin = Assassin.new(assassin_params)
		
		if @assassin.save
			flash[:success] = "Welcome to Assassins!"
			redirect_to @assassin
		else
			render 'new'
		end
	end

	def index
		@assassins = Assassin.all
	end

	private
	def assassin_params
		params.require(:assassin).permit(:name, :email, :password, :password_confirmation)
	end
end
