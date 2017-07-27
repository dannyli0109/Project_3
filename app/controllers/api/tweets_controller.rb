class Api::TweetsController < ApplicationController


  def index
    tweets = twitter_api_call_tweets "ms"

    render json: tweets

  end
end
