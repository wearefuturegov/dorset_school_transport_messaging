class MessagesController < ApplicationController
  
  expose :route
  expose :residents, -> { route.residents }
  
  def create
    residents.each do |r|
      r.send_sms(params[:type], params[:delay_length])
    end
  end
  
end
