class Api::V1::PhotosController < ApplicationController
  respond_to :json

   def index
     respond_with Project.find(params[:project_id]).photos
   end

   def create
     project = current_user.projects.find(params[:project_id])
     photo = project.photos.build(photo_params)
     if photo.save
      render json: photo , status: 201, location: [:api, project ]
     else
       render json: { errors: photo.errors }, status: 422
     end
   end


   private

   def photo_params
     params.require(:photo).permit(:url, :description, :horizontal)
   end

end
