class MicropostsController < ApplicationController
  before_filter :signed_in_user, :only => [ :create, :destroy]
  before_filter :correct_user, :only => :destroy
  
  def index
    @newpost = current_user.microposts.build if signed_in?
    @micropost = Micropost.all
  end
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to '/microposts'
    else
      render signin_path
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to '/microposts'
  end
  
  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to '/microposts' if @micropost.nil?
  end
end
