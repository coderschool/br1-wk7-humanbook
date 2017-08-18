class NotifySlack
  def initialize
    @notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
  end

  def notify_new_post(post, post_url = "/changeme")
    hash = {
      username: post.poster.name_or_email, 
      icon_url: post.poster.image_url_or_default
    }
    if post.image?
      hash[:attachments] = {
        title: post.body,
        title_link: post_url,
        image_url: post.image.url
      }
    end
    @notifier.ping(post.body, hash)
  end
end