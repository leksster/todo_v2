require 'rails_helper'

RSpec.describe Attach, type: :model do

  it { should have_db_column(:file).of_type(:string) }
  
  it { should belong_to(:comment) }

end
