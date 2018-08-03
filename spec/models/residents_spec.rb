require 'rails_helper'

describe Resident, type: :model do
  
  let(:resident) { FactoryBot.create(:resident) }
  
  it 'can have a route' do
    expect(resident.route).to_not be_nil
  end
  
end
