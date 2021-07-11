class Event < ApplicationRecord
  belongs_to :repo, optional: true
  belongs_to :actor, class_name: 'User', optional: true

  validates :event_type, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :event_type, inclusion: { in: %w(PushEvent ReleaseEvent WatchEvent), message: "%{value} is not a valid event type" }
  validates :repo_id, :actor_id, numericality: true
  validate :validate_user
  validate :validate_repo

  def validate_user
  	errors.add(:actor_id, "Actor Id doesn't exists.") if User.find_by(id: actor_id).nil?
  end

  def validate_repo
  	errors.add(:repo_id, "Repo Id doesn't exists.") if Repo.find_by(id: repo_id).nil?
  end	
end
