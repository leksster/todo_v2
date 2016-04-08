require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:tasks) }

  it { should validate_uniqueness_of(:email).case_insensitive }
end
