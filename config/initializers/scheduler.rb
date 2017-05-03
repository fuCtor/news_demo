require 'rufus-scheduler'

unless Rails.env.test?
  s = Rufus::Scheduler.singleton

  s.every '1m' do
    new_news = FetchNews.new.get
    unless News.where(from_yandex: true).where('published_at >= ?', new_news[:published_at]).exists?
      new_news = News.create(new_news)
      if News.current_news == new_news
        NewsChannel.broadcast_to 'index', new_news
      end
    end
  end
end
