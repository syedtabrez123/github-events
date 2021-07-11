require 'rails_helper'

RSpec.describe Repo, type: :model do
  it { should have_many(:events) }
end
