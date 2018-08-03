class Resident < ApplicationRecord
  belongs_to :route
  
  def send_sms(type, delay_length)
    SendSMS.enqueue(phone_number, type, route.id, delay_length)
  end
end
