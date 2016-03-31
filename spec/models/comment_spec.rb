require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_db_column(:text).of_type(:text) }

  it { should validate_presence_of(:text) }

  it { should belong_to(:task) }
  it { should have_many(:attaches).dependent(:destroy) }

  it { should accept_nested_attributes_for(:attaches).allow_destroy(true) }
end
