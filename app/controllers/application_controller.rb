class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  # methods in application controller is available in all controllers
  # since other controllers inherit from it
  def current_user
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user # also make this a helper method for use in views

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def twitter_api_call_trends
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
        clean_word = trend["name"].tr("^A-Za-z0-9 ","")
        if trend["tweet_volume"] != nil && clean_word != ""
          character_array = clean_word.split("")

          i = 1
          while i < character_array.length-1
            if character_array[i] == character_array[i].upcase && character_array[i + 1] == character_array[i + 1].downcase && character_array[i-1] != " " && character_array[i + 1] != " "
              character_array.insert(i, " ")
              i += 1
            end
            i += 1
          end
          clean_word = character_array.join("")
          trends.push (Trend.new clean_word, trend["tweet_volume"], trend["name"])
        end
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
    trends
  end

  def twitter_api_call_tweets word
    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query   = URI.encode_www_form("q" => word, "geocode" => "-22.912214,-43.230182,100km")
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Print data about a Tweet
    def populate_tweets res
      # ADD CODE TO PRINT THE TWEET IN "<screen name> - <text>" FORMAT
      res
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
    res = nil
    tweets = []
    if response.code == '200' then
      res = JSON.parse(response.body)
      tweets = populate_tweets(res)
    end
    tweets
  end

end
