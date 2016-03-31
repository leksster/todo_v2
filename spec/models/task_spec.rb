require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should have_db_column(:text).of_type(:string) }
  it { should have_db_column(:deadline).of_type(:date) }
  it { should have_db_column(:priority).of_type(:integer) }

  it { should validate_presence_of(:text) }

  it { should belong_to(:project) }

  it { should have_many(:comments).dependent(:destroy) }

end
