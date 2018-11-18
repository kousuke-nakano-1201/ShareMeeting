class MenbersController < ApplicationController
  def index
    @menbers = Menber.all
  end

  def show
    @menber = Menber.find(params[:id])
  end

  def new
    @menber = Menber.new
  end

  def create
    @menber = Menber.new(menber_params)
    if @menber.save
      flash[:success] = '社員を登録しました'
      redirect_to menbers_path
    else
      flash.now[:danger] = '社員を登録出来ませんでした'
      render :new
    end
  end

  def edit
    @menber = Menber.find(params[:id])
  end

  def update
    @menber = Menber.find(params[:id])
    if @menber.update(menber_params)
      flash[:success] = '社員の登録情報を更新しました'
      redirect_to menbers_path
    else
      flash.now[:danger] = '社員の登録情報を更新出来ませんでした'
      render :edit
    end
  end

  def destroy
    @menber = Menber.find(params[:id])
    @menber.destroy
    flash[:success] = '社員の登録情報を削除しました'
    redirect_to menbers_path
  end
  
  private

  def menber_params
    params.require(:menber).permit(:name)
  end
end
