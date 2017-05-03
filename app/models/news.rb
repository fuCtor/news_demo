class News < ApplicationRecord
  before_validation :check_date

  validates_presence_of :title, :annotation

  def self.current_news
    self.where('date > ?', Time.now).order('from_yandex asc').order('published_at desc').first
  end

  def check_date
    if from_yandex?
      self.date ||= Time.now + 1.day
    else
      self.published_at = Time.now
      self.date         ||= Time.now + 5.minute
    end

    self.date = self.date.getutc
  end
end
