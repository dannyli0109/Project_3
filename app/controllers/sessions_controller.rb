class SessionsController < ApplicationController


  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:message] = "Successfully logged in!"

      if session[:last_url]
        redirect_to session[:last_url]
      else
        redirect_to "/"
      end

    else

      session[:error_message] = []
      session[:error_message].push "Email or password incorrect"

      redirect_to "/session/new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:message] = "Logged out"
    redirect_to "/"
  end

  def new

  end

end
