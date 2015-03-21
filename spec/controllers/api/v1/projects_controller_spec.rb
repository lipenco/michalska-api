require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project
      get :show, id: @project.id
    end


    it "returns the information about a reporter on a hash" do
      project_response = json_response[:project]
      expect(project_response[:title]).to eql @project.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :project }
      get :index
    end

    it "returns 4 records from the database" do
      projects_response = json_response
      expect(projects_response[:projects]).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @project_attributes = FactoryGirl.attributes_for :project
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, project: @project_attributes }
      end

      it "renders the json representation for the project record just created" do
        project_response = json_response[:project]
        expect(project_response[:title]).to eql @project_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_project_attributes = { title: "" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, project: @invalid_project_attributes }
      end

      it "renders an errors json" do
        project_response = json_response
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        project_response = json_response
        expect(project_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @project = FactoryGirl.create :project, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @project.id,
              project: { title: "new project" } }
      end

      it "renders the json representation for the updated user" do
        project_response = json_response[:project]
        expect(project_response[:title]).to eql "new project"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @project.id,
              project: { title: "" } }
      end

      it "renders an errors json" do
        project_response = json_response
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        project_response = json_response
        expect(project_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @project = FactoryGirl.create :project, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @project.id }
    end

    it { should respond_with 204 }
  end

end
