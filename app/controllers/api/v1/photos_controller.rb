class Api::V1::PhotosController < ApplicationController
  respond_to :json
  
   def index
     respond_with Project.find(params[:project_id]).photos
   end
end
