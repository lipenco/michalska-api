

require 'spec_helper'

RSpec.describe Project do
  let(:product) { FactoryGirl.create :project }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

end
