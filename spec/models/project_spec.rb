require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should have_db_column(:name).of_type(:string) }

  it { should validate_presence_of(:name) }

  it { should have_many(:tasks).dependent(:destroy) }
  it { should belong_to(:user) }
end