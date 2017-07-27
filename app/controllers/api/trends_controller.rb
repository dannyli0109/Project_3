class Api::TrendsController < ApplicationController


  def show
    trends = twitter_api_call_trends

    render json: trends

  end


end
