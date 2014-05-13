require_relative '../spec_helper'

describe 'Root Path' do
  describe 'GET /' do
    before { get '/' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
  describe 'GET /will-fail' do
    before { get '/will-fail' }

    it 'returns a 404' do
      expect(last_response.status).to eq 404
    end
  end
end
