require 'rails_helper'

describe SendSMS do
  
  let(:number) { '1234567' }
  let(:route) { '4' }
  let(:delay_length) { nil }
  let(:type) { 'cancel' }
  let(:subject) { SendSMS.run(number, type, route, delay_length) }

  it 'sends an SMS' do
    expect(SmsService).to receive(:new).with(number, type, route, delay_length) do
      stub = double(SmsService)
      expect(stub).to receive(:perform)
      stub
    end
    subject
  end
  
end
