class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def create
    @message = current_user.sent_messages.build message_params
    if @message.save
      redirect_to messages_sent_path, flash: {success: "Sent."}
    else
      render 'new'
    end
  end

  def sent
    @messages = current_user.sent_messages
  end

  def inbox
    @messages = current_user.received_messages
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
