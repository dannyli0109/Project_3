class Api::NewsController < ApplicationController

  def show
    # puts @name

    @name = params[:name]
    @result = HTTParty.get("http://webhose.io/filterWebContent?token=dbe50032-f200-456e-8767-e35a3267fc54&format=json&ts=1500696728138&sort=crawled&q=%22#{@name}%22%20site_type%3Anews%20thread.country%3AAU&size=5").parsed_response

    posts = @result["posts"]
    news = []
    # title = []
    # image_url
    posts.each do |post|
      news.push({title: post["title"], image_url: post["main_image"], url: post["url"]})
      # title.push(post["title"])
    end
    # raise "stop"

    render json: news
  end

end
