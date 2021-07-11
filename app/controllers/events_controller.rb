class EventsController < ApplicationController
	before_action :set_event, only: [:show]

	def index
		@events = Event.all
		json_response(@events)
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			json_response(@event, :created)
		else
			json_response(@event.errors, :bad_request)
		end	
	end

	def show
		json_response(@event)
	end	

	private

	def event_params
		params.require(:event).permit(:event_type, :public, :repo_id, :actor_id)
	end

	def set_event
		@event = Event.find(params[:id])
	end	
end
