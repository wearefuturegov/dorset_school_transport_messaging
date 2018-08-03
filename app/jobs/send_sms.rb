class SendSMS < Que::Job
  
  def run(number, type, route, delay_length = nil)
    SmsService.new(number, type, route, delay_length).perform
  end
  
end
