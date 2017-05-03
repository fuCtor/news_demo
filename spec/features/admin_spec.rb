require 'spec_helper'

describe 'admin page', type: :feature, js: false do
  let(:news) { build :admin_news }
  it 'show add news form' do
    visit '/admin'
    within('form') do
      expect(page).to have_css('#news_title')
      expect(page).to have_css('#news_annotation')
      expect(page).to have_css('#news_date')
    end
  end

  describe 'news publishing' do
    context 'all field filled' do
      it 'should sucess' do
        visit '/admin'
        within('form') do
          fill_in(id: 'news_title', with: news.title)
          fill_in(id: 'news_annotation', with: news.annotation)
          fill_in(id: 'news_date', with: news.date.to_time.iso8601)

          click_on('Create News')
        end


      end
    end

    context 'title field blank' do
      it 'should should show error' do
        visit '/admin'
        within('form') do
          fill_in(id: 'news_annotation', with: news.annotation)
          fill_in(id: 'news_date', with: news.date.to_s)

          click_on('Create News')
        end

        expect(page).to_not have_css('#news')
        expect(page).to have_css('.flashes')
      end
    end

    context 'annotation field blank' do
      it 'should should show error' do
        visit '/admin'
        within('form') do
          fill_in(id: 'news_title', with: news.title)
          fill_in(id: 'news_date', with: news.date.to_s)

          click_on('Create News')
        end

        expect(page).to_not have_css('#news')
        expect(page).to have_css('.flashes')
      end
    end
  end
end
