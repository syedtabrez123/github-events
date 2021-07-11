require 'rails_helper'

RSpec.describe 'Events API', type: :request do
	let!(:user) { create(:user) }
  let!(:repo) { create(:repo) }

  describe 'POST /events' do
  	context 'when valid attributes are provided' do
  		let(:valid_attributes) { 
  			{ event: 
	  			{ event_type: 'PushEvent', 
	  				public: true, 
	  				repo_id: repo.id, 
	  				actor_id: user.id
	  			} 
  			} 
  		}

  		before { post '/events', params: valid_attributes }

  		it 'returns events' do
	      expect(json).not_to be_empty
	    end

	    it 'returns status code 201' do
	      expect(response).to have_http_status(201)
	    end

	    it 'returns an event object matching above params' do
	    	expect(json["event_type"]).to eq('PushEvent')
	    	expect(json["public"]).to eq(true)
	    	expect(json["repo_id"]).to eq(repo.id)
	    	expect(json["actor_id"]).to eq(user.id)
	    end	
  	end

  	context 'when invalid attributes are provided' do
  		let(:invalid_attributes) { 
  			{ event: 
	  			{ event_type: 'OtherEvent', 
	  				public: nil, 
	  				repo_id: repo.id, 
	  				actor_id: user.id
	  			} 
  			} 
  		}

  		before { post '/events', params: invalid_attributes }

	    it 'returns status code 400' do
	      expect(response).to have_http_status(400)
	    end

	    it 'returns invalid event type' do
	      expect(json["event_type"].first).to match(/OtherEvent is not a valid event type/)
	      expect(json["public"].first).to match(/is not included in the list/)
	    end
  	end
  end

  describe 'GET /events' do
    let!(:events) { create_list(:event, 10, actor: user, repo: repo) }

    before { get '/events' }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id' do
  	context 'when valid event id is provided' do
	    let!(:event) { create(:event, actor: user, repo: repo) }

	    let(:valid_id) { event.id }

	    before { get "/events/#{valid_id}" }

	    it 'returns events' do
	      expect(json).not_to be_empty
	    end

	    it 'returns status code 200' do
	      expect(response).to have_http_status(200)
	    end

	    it 'returns an event object matching above params' do
	    	expect(json["event_type"]).to eq(event.event_type)
	    	expect(json["public"]).to eq(event.public)
	    	expect(json["repo_id"]).to eq(repo.id)
	    	expect(json["actor_id"]).to eq(user.id)
	    end
	  end

	  context 'when invalid event id is provided' do

	    let(:invalid_id) { 0 }

	    before { get "/events/#{invalid_id}" }

	    it 'returns error message' do
	      expect(json["message"]).to match(/Couldn't find Event with 'id'=0/)
	    end

	    it 'returns status code 404' do
	      expect(response).to have_http_status(404)
	    end 
  	end
  end
end	