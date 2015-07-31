class AssassinsController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :index, :destroyS]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

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

	def edit
		@assassin = Assassin.find(params[:id])
	end

	def update
		@assassin = Assassin.find(params[:id])
		if @assassin.update_attributes(assassin_params)
			flash[:success] = "Profile Updated!"
			redirect_to @assassin
		else
			render 'edit'
		end
	end

	def index
		@assassins = Assassin.paginate(page: params[:page])
	end

	def destroy
		Assassin.find(params[:id]).destroy
		flash[:success] = "Assassin deleted"
		redirect_to assassins_url
	end

	private
	def assassin_params
		params.require(:assassin).permit(:name, :email, :password, :password_confirmation)
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def correct_user
		@assassin = Assassin.find(params[:id])
		redirect_to(root_url) unless current_user?(@assassin)
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
