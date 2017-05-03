class NewsController < ApplicationController
  def index
    @news = News.current_news
  end

  def show
    @news = News.new
  end

  def create
    # binding.pry
    @news = News.new(news_params)
    if @news.save
      NewsChannel.broadcast_to 'index', @news
      redirect_to root_path
    else
      flash.now[:error] = 'News contains empty field'
      render :show
    end
  end

  private

  def news_params
    @news_params ||= params.require(:news).permit(:title, :annotation, :date).merge(from_yandex: false)
  end
end
