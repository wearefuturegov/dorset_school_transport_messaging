require 'rails_helper'

describe Resident, type: :model do
  
  let(:resident) { FactoryBot.create(:resident) }
  
  it 'can have a route' do
    expect(resident.route).to_not be_nil
  end
  
  describe '#send_sms' do
    
    let(:subject) { resident.send_sms(type: 'delay', delay_length: '30') }
    let(:job) { QueJob.first }
    
    it 'queues up a sms message' do
      expect { subject }.to change { QueJob.count }.by(1)
    end
    
    it 'queues the correct args' do
      subject
      expect(job.job_class).to eq('SendSMS')
      expect(job.args.first).to match({
        'phone_number' => resident.phone_number,
        'type' => 'delay',
        'route' => resident.route.id,
        'delay_length' => '30'
      })
    end
    
  end

end
