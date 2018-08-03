require_relative 'fake_sms'

SmsService.client = FakeSMS

RSpec.configure do |config|
  config.before :each do
    FakeSMS.messages = []
  end
end
