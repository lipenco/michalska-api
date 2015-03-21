class Api::V1::ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:create]

  def show
    respond_with Project.find(params[:id])
  end

  def index
    respond_with Project.all
  end

  def create
    project = current_user.projects.build(project_params)
    if project.save
      render json: project, status: 201, location: [:api, project]
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def update
    project = current_user.projects.find(params[:id])
    if project.update(project_params)
      render json: project, status: 200, location: [:api, project]
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def destroy
    project = current_user.projects.find(params[:id])
    project.destroy
    head 204
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :published, :thumbnail)
  end

end
