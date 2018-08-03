require 'rails_helper'

describe MessagesController, type: :controller do
  
  describe '#create' do
    let(:route_1) { FactoryBot.create(:route) }
    let(:route_2) { FactoryBot.create(:route) }

    let(:route_1_residents) { FactoryBot.create_list(:resident, 6, route: route_1) }
    let(:route_2_residents) { FactoryBot.create_list(:resident, 3, route: route_2) }
    
    let(:subject) do
      post :create, {
        params: {
          route_id: route_1.id,
          type: 'delay',
          delay_length: '30'
        }
      }
    end
    
    it 'queues jobs for the correct residents' do
      expect(controller).to receive(:residents) { route_1_residents }
      
      route_1_residents.each do |r|
        expect(r).to receive(:send_sms).with('delay', '30').once
      end
      
      subject
    end

  end
  
end
