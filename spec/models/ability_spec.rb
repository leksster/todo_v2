require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'guest' do
    let(:user) { create(:user) }
    let(:ability) { Ability.new(user) }

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, Project) }
      it { expect(ability).not_to be_able_to(:manage, Task) }
      it { expect(ability).not_to be_able_to(:manage, Comment) }
    end
  end
end