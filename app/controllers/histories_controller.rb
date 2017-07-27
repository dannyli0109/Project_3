class HistoriesController < ApplicationController

	def show
		@histories = History.where(user_id: current_user)
		# raise "stop"

	end

	def create
		# @history = "webwdlvrgvdfc"
		history = History.new(name: params[:history][:name], location: params[:history][:location])
		history.user = current_user
		history.save
		# @history = "vrvgvujkj"
		# raise "stop"
		render json: {"status": "success"}
	end

end