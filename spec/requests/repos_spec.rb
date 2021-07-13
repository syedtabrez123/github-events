require 'rails_helper'

RSpec.describe 'Repos API', type: :request do
	let!(:user) { create(:user) }
  let!(:repo) { create(:repo) }
	describe 'GET /repos/:repo_id/events' do
    let!(:events) { create_list(:event, 5, actor: user, repo: repo) }

    before { get "/repos/#{repo.id}/events" }

    it 'returns repo events' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end