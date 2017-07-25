class Api::NewsController < ApplicationController

  def show
    # puts @name

    @name = params[:name]
    @result = HTTParty.get("http://webhose.io/filterWebContent?token=dbe50032-f200-456e-8767-e35a3267fc54&format=json&ts=1498405474844&sort=published&q=#{@name}%20site_type%3Anews%20thread.country%3AAU&size=10").parsed_response


    posts = @result["posts"]
    news = []
    # title = []
    # image_url
    posts.each do |post|
      news_single = News.new post["thread"]["title"], post["thread"]["main_image"], post["thread"]["url"]
      news.push(news_single)
      # title.push(post["title"])
    end
    # raise "stop"

    render json: news
  end

end
