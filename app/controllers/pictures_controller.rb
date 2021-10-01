class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    @users = User.select(:id, :name)
  end
  def new
    @picture = Picture.new
  end
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to pictures_path
    else
      render :new
    end
  end
  def show
    @picture = Picture.find(params[:id])
  end
  def edit
    @picture = Picture.find(params[:id])
  end
  def update
    
  end
  
  
  

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

end
