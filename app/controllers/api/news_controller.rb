class Api::NewsController < ApplicationController

  def show
    # puts @name

    @name = params[:name]
    @result = HTTParty.get("http://webhose.io/filterWebContent?token=dbe50032-f200-456e-8767-e35a3267fc54&format=json&ts=1498405474844&sort=published&q=#{@name}%20site_type%3Anews%20thread.country%3AAU&size=10").parsed_response


    posts = @result["posts"]
    news = []
    
    posts.each do |post|
      if news.length > 0
        if !news.any? { |e| e.title ==  post["thread"]["title"]}
          news_single = News.new post["thread"]["title"], post["thread"]["main_image"], post["thread"]["url"]
          news.push(news_single)
        end

      else
        news_single = News.new post["thread"]["title"], post["thread"]["main_image"], post["thread"]["url"]
        news.push(news_single)
      end 
    end
    
    render json: news

  end

end
