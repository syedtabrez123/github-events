class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :public
  belongs_to :repo
  belongs_to :actor, class_name: 'User'
end
