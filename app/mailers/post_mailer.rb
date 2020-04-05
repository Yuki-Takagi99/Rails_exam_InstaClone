class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: @post.user.email, subject: "新規ポストのお知らせ"
  end
end
