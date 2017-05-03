require 'spec_helper'

RSpec.describe NewsController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do

    context 'correct data' do
      it 'should create news' do
        expect(NewsChannel).to receive(:broadcast_to)

        news = attributes_for(:admin_news)
        post :create, params: { news: news }
        expect(response).to have_http_status(302)

        created_news = News.current_news

        expect(created_news.title).to eq news[:title]
        expect(created_news.annotation).to eq news[:annotation]
        expect(created_news.date.getutc).to eq news[:date].getutc
      end
    end

    context 'wrong data' do
      it 'returns http success' do
        expect(NewsChannel).to_not receive(:broadcast_to)
        news = attributes_for(:admin_news).except(:title)
        post :create, params: { news: news }
        expect(response).to have_http_status(200)

        expect(News.current_news).to be_blank
      end
    end
  end
end
