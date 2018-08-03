require 'rails_helper'

describe SmsService do
  
  let(:subject) { SmsService.new(number, type, route, delay_length) }
  let(:number) { '1234567' }
  let(:route) { '4' }
  let(:delay_length) { nil }
  
  context 'with a delay' do
    
    let(:type) { 'delay' }
    let(:delay_length) { 30 }
    
    it 'sends a message' do
      expect { subject.perform }.to change { FakeSMS.messages.count }.by(1)
    end
    
    it 'sends the right message' do
      subject.perform
      expect(FakeSMS.messages.first[:body]).to match(/route #{route} by approximately #{delay_length} minutes./)
    end
    
  end
  
  context 'with a cancellation' do
    
    let(:type) { 'cancel' }
    
    it 'sends a message' do
      expect { subject.perform }.to change { FakeSMS.messages.count }.by(1)
    end
    
    it 'sends the right message' do
      subject.perform
      expect(FakeSMS.messages.first[:body]).to match(/your school bus service on route #{route} has been cancelled for today/)
    end
    
  end
  
end
