require 'rails_helper'

RSpec.describe PhotosController, type: :controller do

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

     context "when is not created" do
       before(:each) do
         @user = FactoryGirl.create :user
         @project_attributes = FactoryGirl.attributes_for :project
         @invalid_photo_attributes  = { url: "" }
         api_authorization_header @user.auth_token
         @project = FactoryGirl.create :project, user: @user
         post :create, { user_id: @user.id, project_id: @project.id, photo: @invalid_photo_attributes }

       end

       it "renders an errors json" do
         photo_response = json_response
         expect(photo_response).to have_key(:errors)
       end

       it "renders the json errors" do
         photo_response = json_response
         expect(photo_response[:errors][:url]).to include "can't be blank"
       end

       it { should respond_with 422 }
     end
   end


   describe "PUT/PATCH #update" do
     before(:each) do
       @user = FactoryGirl.create :user
       @project = FactoryGirl.create :project, user: @user
       @photo = FactoryGirl.create :photo, project: @project
       api_authorization_header @user.auth_token
     end

     context "when is successfully updated" do
       before(:each) do
         patch :update, { user_id: @user.id, project_id:@project.id, id: @photo.id,
               photo: { url: "new project" } }
       end

       it "renders the json representation for the updated user" do
         photo_response = json_response[:photo]
         expect(photo_response[:url]).to eql "new project"
       end

       it { should respond_with 200 }
     end


     context "when is not updated" do
       before(:each) do
         patch :update, {  user_id: @user.id, project_id: @project.id, id: @photo.id,
               photo: { url: "" } }
       end

       it "renders an errors json" do
         photo_response = json_response
         expect(photo_response).to have_key(:errors)
       end

       it "renders the json errors on whye the user could not be created" do
         photo_response = json_response
         expect(photo_response[:errors][:url]).to include "can't be blank"
       end

       it { should respond_with 422 }
     end
   end

   describe "DELETE #destroy" do
     before(:each) do
       @user = FactoryGirl.create :user
       @project = FactoryGirl.create :project, user: @user
       @photo = FactoryGirl.create :photo, project: @project
       api_authorization_header @user.auth_token
       delete :destroy, { user_id: @user.id, project_id: @project.id, id: @photo.id }

      #  @user = FactoryGirl.create :user
      #  @project = FactoryGirl.create :project, user: @user
      #  api_authorization_header @user.auth_token
      #  delete :destroy, { user_id: @user.id, id: @project.id }
     end

     it { should respond_with 204 }
   end

   describe "GET #featured" do
     context "gets photos featured:true" do
       before(:each) do
         @project = FactoryGirl.create :project
         4.times { FactoryGirl.create :photo, project: @project }
         get :featured, project_id: @project
       end

       it "returns 4 photos records from the project" do
         photos_response = json_response[:photo]
         expect(photos_response).to have(4).items
       end

       it { should respond_with 200 }
     end
   end


end
