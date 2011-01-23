class ChatMessagesController < ApplicationController
  def index
    @chat_messages = ChatMessage.paginate :page => params[:page], :order => 'created_at DESC'
  end
end
