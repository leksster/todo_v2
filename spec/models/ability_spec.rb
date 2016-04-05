require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'user' do
    let(:valid_user) { create(:user) }
    let(:invalid_user) { create(:user) }
    let(:ability) { Ability.new(valid_user) }

    context 'can' do
      it { expect(ability).to be_able_to(:manage, Project.new(user:valid_user)) }
      it { expect(ability).to be_able_to(:manage, Task.new(project:Project.new(user:valid_user))) }
      it { expect(ability).to be_able_to(:manage, Comment.new(task:Task.new(project:Project.new(user:valid_user)))) }
    end

    context 'cannot' do
    	it { expect(ability).to_not be_able_to(:manage, Project.new) }
    	it { expect(ability).to_not be_able_to(:manage, Project.new(user:invalid_user)) }
    	it { expect(ability).to_not be_able_to(:manage, Task.new) }
      it { expect(ability).to_not be_able_to(:manage, Task.new(project:Project.new(user:invalid_user))) }
      it { expect(ability).to_not be_able_to(:manage, Comment.new) }
      it { expect(ability).to_not be_able_to(:manage, Comment.new(task:Task.new(project:Project.new(user:invalid_user)))) }
    end
  end
end