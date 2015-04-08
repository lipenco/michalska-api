class ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:create, :update]
  skip_before_filter  :verify_authenticity_token

  def show
    respond_with Project.find(params[:id])
  end

  def index
    respond_with Project.all
  end

  def create
    project = current_user.projects.build(project_params)
    set_up_flickr(project)
    if project.save
      render json: project, status: 201
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def update
    project = current_user.projects.find(params[:id])
    set_up_flickr(project)
    if project.update(project_params)
      render json: project, status: 200
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
    params.require(:project).permit(:title, :description, :project_date, :published, :thumbnail, :photoset_id, :flickr_name)
  end

  def set_up_flickr(project)
    response = Net::HTTP.get(URI("https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=39468a9a4f9928a152830d3ad9720e8d&user_id=130636143%40N05&format=json&nojsoncallback=1"))
    response = JSON.parse(response)
    response['photosets']["photoset"].each do |photoset|
      if photoset['title']['_content'] == params[:flickr_name]
        puts photoset['title']['_content']
        project.thumbnail = "https://farm#{photoset['farm']}.staticflickr.com/#{photoset['server']}/#{photoset['primary']}_#{photoset['secret']}.jpg"
        project.photoset_id = photoset['id']
      end
    end
  end

end
