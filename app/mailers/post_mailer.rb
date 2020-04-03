class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "yuki99takagi@gmail.com", subject: "新規ポストのお知らせ"
  end
end
