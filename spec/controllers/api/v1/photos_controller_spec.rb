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

   describe "POST #create" do
     context "when is successfully created" do
       before(:each) do
         @user = FactoryGirl.create :user
         @project_attributes = FactoryGirl.attributes_for :project
         @photo_attributes = FactoryGirl.attributes_for :photo
         api_authorization_header @user.auth_token
         @project = FactoryGirl.create :project, user: @user
         post :create, { user_id: @user.id, project_id: @project.id, photo: @photo_attributes }
       end

       it "renders the json representation for the photo record just created" do
         photo_response = json_response[:photo]
         expect(photo_response[:id]).to eql @project.id
       end

       it { should respond_with 201 }
     end
   end


end
