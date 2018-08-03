require 'rails_helper'

describe SmsService do
  
  let(:subject) { SmsService.new(params) }
  let(:number) { '1234567' }
  let(:route) { '4' }
  let(:body) { FakeSMS.messages.first[:body] }
  
  context 'with a delay' do
    
    let(:delay_length) { 30 }
    let(:params) { { number: number, route: route, type: 'delay', delay_length: delay_length } }
    
    it 'sends a message' do
      expect { subject.perform }.to change { FakeSMS.messages.count }.by(1)
    end
    
    it 'sends the right message' do
      subject.perform
      expect(body).to match(/route #{route}/)
      expect(body).to match(/has been delayed by approximately #{delay_length} minutes./)
    end
    
    context 'in the morning', :timecop do
      
      before { Timecop.freeze('2018-01-01 08:30:00') }
      
      it 'gives the correct time of day' do
        subject.perform
        expect(body).to match(/morning school bus service/)
      end
      
    end
    
    context 'in the afternoon', :timecop do
      
      before { Timecop.freeze('2018-01-01 15:30:00') }
      
      it 'gives the correct time of day' do
        subject.perform
        expect(body).to match(/afternoon school bus service/)
      end
      
    end
    
  end
  
  context 'with a cancellation' do
  
    let(:params) { { number: number, route: route, type: 'cancel', reason: 'snow' } }
    
    it 'sends a message' do
      expect { subject.perform }.to change { FakeSMS.messages.count }.by(1)
    end
    
    it 'sends the right message' do
      subject.perform
      expect(body).to match(/route #{route}/)
      expect(body).to match(/has been cancelled for today/)
      expect(body).to match(/This is due to snow/)
    end
    
  end
  
end
