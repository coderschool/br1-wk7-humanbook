class PostMailer < ApplicationMailer
  default from: "support@humanbuuk.vn"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.new_post.subject
  #
  def new_post(post)
    @user = post.wall_user
    @post = post

    mail to: @user.email, subject: "Someone just posted on your wall.", reply_to: post.poster.email
  end
end
