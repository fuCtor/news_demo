require 'spec_helper'


describe 'general page render', :type => :feature do
  let!(:news) do
    create :news
  end

  it 'show current news' do
    visit '/'
    expect(find('#news')['data-until']).to eq news.date.to_time.iso8601
    within('#news') do
      expect(page).to have_css('.news-title', text: news.title)
      expect(page).to have_css('.news-annotation', text: news.annotation)
    end
  end
end
