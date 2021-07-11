class ReposController < ApplicationController
	before_action :set_repo, only: [:index]

	def index
		json_response(@repo.events)
	end

	private
	def set_repo
		@repo = Repo.find(params[:repo_id])
	end
end
