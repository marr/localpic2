class Api::V1::PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :update, :destroy]
  def index
    @pictures = Picture.all
    if @pictures
      render json: @pictures,
             each_serializer: PictureSerializer,
             root: "pictures"
    else
      @error = Error.new(text: "404 Not found",
                         status: 404,
                         url: request.url,
                         method: request.method)
      render json: @error.serializer
    end
  end

  def show
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      render json: @picture,
             serializer: PictureSerializer,
             meta: { status: 201,
                     message: "201 Created",
                     location: @picture
             },
             root: "picture"
    else
      @error = Error.new(text: "500 Server Error",
                         status: 500,
                         url: request.url,
                         method: request.method)
      render json: @error.serializer
    end
  end

  def update
  end

  def delete
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:title, :image)
  end
end
