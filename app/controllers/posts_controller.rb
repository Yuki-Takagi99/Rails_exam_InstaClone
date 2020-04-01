class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "新規ポストしました！"
      else
        render :new
      end
    end
  end
  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end
  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "ポストを編集しました！"
    else
      render :edit
    end
  end
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "ポストを削除しました！"
  end
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid? #バリデーションに失敗したとき、新規投稿画面に戻る
  end
  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
