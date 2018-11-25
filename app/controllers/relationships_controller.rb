class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @menbers = Menber.where(attend: true)
  end
  
  def create
    menber1 = Menber.find(params[:menber_id])
    menber2 = Menber.find(params[:follow_id])
    menber1.follow(menber2)
    flash[:success] = 'ユーザをフォローしました。'
    redirect_to menber1
  end

  def destroy
    menber1 = Menber.find(params[:menber_id])
    menber2 = Menber.find(params[:follow_id])
    menber1.unfollow(menber2)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_to menber1
  end
end
