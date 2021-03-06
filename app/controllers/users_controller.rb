class UsersController < ApplicationController
  before_action :must_login, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) #user_paramsでPOSTデータをチェック
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

  def edit #他人のプロフィールの編集画面に入った場合、投稿一覧に戻す
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to posts_path
    end
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

  def favorite_index
    @favorite = current_user.favorite_posts.all #現在のユーザのお気に入りポストを取得
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
