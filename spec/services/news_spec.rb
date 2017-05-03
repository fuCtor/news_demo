require 'spec_helper'
require 'fetch_news'

RSpec.describe FetchNews, type: :service do
  subject { FetchNews.new.get }

  describe '#get' do
    it 'return hash' do
      VCR.use_cassette('yandex') do
        expect(subject).to be_instance_of Hash
      end
    end

    %i(title annotation published_at).each do |key|
      it "must contains #{key}" do
        VCR.use_cassette('yandex') do
          expect(subject).to be_key key
          expect(subject[key]).to be_present
        end
      end
    end
  end
end
