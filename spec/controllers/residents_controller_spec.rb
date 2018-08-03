require 'rails_helper'

describe ResidentsController, type: :controller do
  
  describe '#create' do
    
    let(:subject) do
      post :create, {
        params: {
          resident: {
            phone_number: '+44123456778'
          }
        }
      }
    end
    
    it 'creates a user' do
      expect { subject }.to change { Resident.all.count }.by(1)
    end
    
    it 'creates the correct phone number' do
      subject
      expect(Resident.last.phone_number).to eq('+44123456778')
    end
    
    it 'returns json' do
      subject
      expect(response.body['route_id']).to_not be_nil
    end
    
  end
  
end
