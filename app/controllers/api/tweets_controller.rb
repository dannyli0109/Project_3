class Api::TweetsController < ApplicationController


  def index
    tweets = twitter_api_call_tweets params[:name], params[:geocode]
    render json: tweets
  end
end
