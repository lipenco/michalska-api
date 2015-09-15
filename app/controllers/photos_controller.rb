require 'net/http'

class PhotosController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:create, :update, :destroy, :flickr]
  before_action :setUpProject, only: [:create, :update, :destroy, :flickr]


   def index
     respond_with Project.find(params[:project_id]).photos
   end

   def featured
     respond_with Photo.where featured: true
   end

   def flickr
     response = Net::HTTP.get(URI("https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=39468a9a4f9928a152830d3ad9720e8d&photoset_id=#{@project.photoset_id}&user_id=130636143%40N05&format=json&nojsoncallback=1"))
     response = JSON.parse(response)
     response['photoset']['photo'].each do |photo|
       sizeResponse = Net::HTTP.get(URI("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=39468a9a4f9928a152830d3ad9720e8d&photo_id=#{photo['id']}&format=json&nojsoncallback=1"))
       sizeResponse = JSON.parse(sizeResponse)
       url = sizeResponse['sizes']['size'].last['source']
       if sizeResponse['sizes']['size'].last["width"].to_f > sizeResponse['sizes']['size'].last["height"].to_f
         horizontal = true
       else
         horizontal = false
       end
       photo = @project.photos.build({:url => url, :horizontal => horizontal})
       photo.save
     end
     render json: @project , status: 201
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
