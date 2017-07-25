class UsersController < ApplicationController


  def new

  end

  def create
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    if user.valid?
      session[:message] = "Successfully registered"
      user.save
      session[:user_id] = user.id
      if session[:last_url]
        redirect session[:last_url]
      else
        redirect_to "/"
      end
    else
      session[:error_message] = []
      user.errors.messages.each do |key, value|
        value.each do |element|
          session[:error_message].push("#{key.capitalize} #{element}.")
        end
      end
      redirect_to "/users/new"
    end
  end


  
end
