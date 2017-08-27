class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def create
    @message = current_user.sent_messages.build message_params
    if @message.save
      WebNotificationsChannel.broadcast_to @message.recipient, html: helpers.badge_nav_link_content(@message.recipient.unseen_messages_count + 1)
      redirect_to sent_messages_path, flash: {success: "Sent."}
    else
      render 'new'
    end
  end

  def sent
    @messages = current_user.sent_messages
  end

  def inbox
    @messages = current_user.received_messages
    @messages.each {|e| e.mark_as_seen!}
  end

  def index
    redirect_to inbox_messages_path
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
