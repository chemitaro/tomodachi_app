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
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "投稿しました"
      else
        render :new
      end
    end
  end
  def show
    @picture = Picture.find(params[:id])
  end
  def edit
    @picture = Picture.find(params[:id])
  end
  def update
    @picture = Picture.find(params[:id])
    if @picture.user_id == current_user.id
      if @picture.update(picture_params)
        redirect_to pictures_path, notice: "更新しました"
      else
        render :edit
      end
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end
  def destroy
    @picture = Picture.find(params[:id])
    if @picture.user_id == current_user.id 
      @picture.destroy
      redirect_to pictures_path, notice: "投稿を削除しました"
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
  end
  
  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

end
