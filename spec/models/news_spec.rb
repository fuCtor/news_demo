require 'spec_helper'

RSpec.describe News, type: :model do
  subject { build :news }

  describe '#current_news' do
    subject { described_class }
    it do
      expect(subject).to be_respond_to :current_news
    end

    it 'should have return news' do
      create :news
      expect(subject.current_news).to be_instance_of News
    end

    context 'actual published news' do
      let!(:admin_news) { create :admin_news }
      before do
        create :news
      end

      it 'should have return news' do
        Timecop.travel(admin_news.date - 1)
        expect(subject.current_news.from_yandex).to be_falsy
      end
    end

    context 'not actual published news' do
      let!(:admin_news) { create :admin_news }
      before do
        create :feature_news
      end

      it 'should have return news' do
        Timecop.travel(admin_news.date + 1)
        expect(subject.current_news.from_yandex).to be_truthy
      end
    end

  end

  %i(title annotation date from_yandex).each do |f|
    it "should have #{f}" do
      expect(subject).to be_respond_to f
    end
  end
end
