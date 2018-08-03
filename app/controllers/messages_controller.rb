class MessagesController < ApplicationController
  
  expose :route
  expose :residents, -> { route.residents }
  
  def create
    residents.each do |r|
      r.send_sms(sms_params.to_hash)
    end
  end
  
  private
    
    def sms_params
      params.permit(:type, :delay_length)
    end
  
end
