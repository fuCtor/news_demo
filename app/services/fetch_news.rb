require 'httparty'

class FetchNews
  include HTTParty
  base_uri 'https://news.yandex.ru/'
  USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0'.freeze

  class Parser::RSS < HTTParty::Parser
    SupportedFormats.merge!({"application/rss+xml" => :rss})

    protected

    # perform parsing on body
    def rss
      Nokogiri::XML(body)
    end
  end

  parser Parser::RSS

  def get
    get_items.first.try do |item|
      title       = item.xpath('title').first
      description = item.xpath('description').first
      date        = item.xpath('pubDate').first.text.strip
      date        = Time.parse(date)

      {
        title:         title.text.strip,
        annotation:    description.text.strip,
        published_at: date
      }
    end
  end

  private

  def get_items
    options = {
      headers: {
        'User-Agent' => USER_AGENT,
        'Accept'     => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
      }
    }
    self.class.get("/index.rss", options).xpath('//item')
  end
end
