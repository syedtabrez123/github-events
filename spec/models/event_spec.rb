require 'rails_helper'

RSpec.describe Event, type: :model do
	# Associations
  it { should belong_to(:repo) }
  it { should belong_to(:actor) }

  # Validations
  it { should validate_presence_of(:event_type) }
  it { should validate_inclusion_of(:public).in_array([true, false]) }
  it { should validate_inclusion_of(:event_type).in_array(%w(PushEvent ReleaseEvent WatchEvent))}
end
