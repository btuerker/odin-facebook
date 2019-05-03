class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]
  before_action :require_authorized_user, only: [:destroy]

  def create
    @like = current_user.likes.build(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like.post, success: "Liked post!"}
        format.json { render json: @like, status: :created, location: @like }
        format.js
      else
        format.html { redirect_back fallback_location: root_path , danger: "Something went wrong!"}
        format.json { render json: @like.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json  { head :ok }
      format.js
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:post_id)
  end

  def require_authorized_user
    unless @like.user == current_user
      flash[:danger] = "You're not authorized"
      redirect_back(fallback_location: root_path)
    end
  end
end
