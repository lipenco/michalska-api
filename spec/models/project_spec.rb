

require 'spec_helper'

RSpec.describe Project do
  let(:project) { FactoryGirl.create :project }
  subject { project}

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  it { should have_many(:photos) }


  it { should belong_to :user }

end
