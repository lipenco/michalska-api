require 'rails_helper'

RSpec.describe Photo, type: :model do

  describe Photo do
    let(:photo) { FactoryGirl.build :photo }
    subject { photo }

    it { should respond_to(:url) }
    it { should respond_to(:project_id) }

    it { should validate_presence_of :project_id }
    it { should validate_presence_of :url}

    it { should belong_to :project }
  end

end
