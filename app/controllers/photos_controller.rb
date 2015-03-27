class PhotosController < ApplicationController
  respond_to :json
  before_action :setUpProject, only: [:create, :update, :destroy]


   def index
     respond_with Project.find(params[:project_id]).photos
   end

   def featured
     respond_with Photo.where featured: true
   end

   def create
     photo = @project.photos.build(photo_params)
     if photo.save
      render json: photo , status: 201
     else
       render json: { errors: photo.errors }, status: 422
     end
   end

   def update
     photo = @project.photos.find(params[:id])
     if photo.update(photo_params)
       render json: photo, status: 200
     else
       render json: { errors: photo.errors }, status: 422
     end
   end

   def destroy
     photo = @project.photos.find(params[:id])
     photo.destroy
     head 204
   end


   private

   def photo_params
     params.require(:photo).permit(:url, :description, :horizontal, :featured, :project_id)
   end

   def setUpProject
     @project = current_user.projects.find(params[:project_id])
   end

end
