class PostsController < ApplicationController
  before_action :must_login, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(updated_at: "DESC")
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        PostMailer.post_mail(@post).deliver ##新規投稿確認メール送信処理
        redirect_to posts_path, notice: "新規ポストしました！"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit #他人の投稿の編集画面に入った場合、投稿一覧に戻す
    if current_user.id != @post.user.id
      redirect_to posts_path
    end
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
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
