class Api::TrendsController < ApplicationController


  def show
    # Now you will fetch /1.1/statuses/show.json, which
    # takes an 'id' parameter and returns the
    # representation of a single Tweet.

    baseurl = "https://api.twitter.com"
    path    = "/1.1/trends/place.json"
    query   = URI.encode_www_form("id" => params[:id])
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Print data about a Tweet
    def populate_trends(tweet)
      # ADD CODE TO PRINT THE TWEET IN "<screen name> - <text>" FORMAT

      trends = []
      tweet[0]["trends"].each do |trend|
        trends.push (Trend.new trend["name"].tr("^A-Za-z0-9 ",""))
      end

      trends
    end

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # If you entered your credentials in the first
    # exercise, no need to enter them again here. The
    # ||= operator will only assign these values if
    # they are not already set.
    consumer_key ||= OAuth::Consumer.new "53ds5Y5kdchwb2xPZxfZJMuAw", "6nKZ82d9PDs5hhUt8TEZ5TS0LscX0TMI75gpU2XZvmbSfgXKej"
    access_token ||= OAuth::Token.new "889375513109606400-IJDGawfJMAVH8ZYSg8HAqZBcOLatLGB", "UwjjLkKxtBKpOLSrgu75NHEElH57ofTwceUqWewkRiBsS"

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    tweet = nil
    trends = []
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      trends = populate_trends(tweet)
    end

    render json: trends
  end


end
