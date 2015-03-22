require 'rails_helper'

RSpec.describe Api::V1::PhotosController, type: :controller do

  describe "GET #index" do
   before(:each) do
     @project = FactoryGirl.create :project
     4.times { FactoryGirl.create :photo, project: @project }
     get :index, project_id: @project
   end

   it "returns 4 photos records from the project" do
     photos_response = json_response[:photos]
     expect(photos_response).to have(4).items
   end

   it { should respond_with 200 }
 end

end
