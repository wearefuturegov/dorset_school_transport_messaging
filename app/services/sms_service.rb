require 'twilio-ruby'

class SmsService
  
  cattr_accessor :client
  self.client = Twilio::REST::Client
  
  def initialize(params)
    @client = self.client.new
    @number = params[:number]
    @type = params[:type]
    @route = params[:route]
    @delay_length = params[:delay_length]
  end
  
  def perform
    @client.api.account.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: @number,
      body: message
    )
  end
  
  private
  
    def message
      @type == 'cancel' ? cancellation_message : delay_message
    end
    
    def cancellation_message
      """
        This is Dorset County Council's school transport service. Unfortunately
        your school bus service on route #{@route} has been cancelled for today
      """.squish
    end
    
    def delay_message
      """
        This is Dorset County Council's school transport service. There is a
        delay to your bus service on route #{@route} by approximately
        #{@delay_length} minutes.
      """.squish
    end
  
end
