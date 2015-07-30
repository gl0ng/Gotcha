class SessionsController < ApplicationController

	def new
	end

  def create
    assassin = Assassin.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if assassin && assassin.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:assassin_id] = assassin.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:assassin_id] = nil
    redirect_to '/login'
  end

end
