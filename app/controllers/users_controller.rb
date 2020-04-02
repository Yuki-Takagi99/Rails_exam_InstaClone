class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params) #user_paramsでcPOSTデータをチェック
    if @user.save #保存できていたら
      flash[:success] = '新しいユーザーを登録しました。'
      session[:user_id] = @user.id
      redirect_to user_path(@user.id) #ユーザ詳細画面に遷移
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new #ユーザ登録画面に遷移
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました！'
        redirect_to user_path(@user.id) #ユーザ詳細画面に遷移
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit #ユーザ編集画面に遷移
      end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
