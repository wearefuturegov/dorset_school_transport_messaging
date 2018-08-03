class Resident < ApplicationRecord
  belongs_to :route
  
  def send_sms(params)
    SendSMS.enqueue(params.merge({phone_number: phone_number, route: route.id}))
  end
end
