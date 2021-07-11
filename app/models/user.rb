class User < ApplicationRecord
	has_many :events, foreign_key: :actor_id
end
