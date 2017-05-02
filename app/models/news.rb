class News < ApplicationRecord
  before_validation :check_date

  validates_presence_of :title, :annotation

  def self.current_news
    self.where('date > ?', Time.now).order('published_at asc').first
  end

  def check_date
    if from_yandex?
      self.date ||= Time.now + 1.day
    else
      self.date ||= Time.now + 5.minute
    end
  end

end
