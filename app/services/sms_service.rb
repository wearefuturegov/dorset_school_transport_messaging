require 'twilio-ruby'

class SmsService
  
  cattr_accessor :client
  self.client = Twilio::REST::Client
  
  def initialize(params)
    @client = self.client.new
    @number = params[:phone_number]
    @type = params[:type]
    @route = params[:route]
    @delay_length = params[:delay_length]
    @reason = params[:reason]
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
    
    def intro
      """
        This is Dorset County Council's school transport service. Unfortunately
        your #{time_of_day} school bus service on route #{@route} on #{date}
      """.squish
    end
    
    def cancellation_message
      """
        #{intro} has been cancelled for today. This is due to #{@reason}
      """.squish
    end
    
    def delay_message
      """
        #{intro} has been delayed by approximately #{@delay_length} minutes.
      """.squish
    end
    
    def time_of_day
      today = Date.today.to_time
      case Time.now
      when today.beginning_of_day..today.noon
        'morning'
      when today.noon..today.change( hour: 19 )
        'afternoon'
      end
    end
    
    def date
      Date.today.strftime('%e %B %Y')
    end
  
end
