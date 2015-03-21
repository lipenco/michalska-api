require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project
      get :show, id: @project.id
    end

    it "returns the information about a reporter on a hash" do
      project_response = json_response
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

end
