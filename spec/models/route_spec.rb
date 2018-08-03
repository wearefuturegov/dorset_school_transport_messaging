require 'rails_helper'

describe Route, type: :model do
  
  let(:residents) { FactoryBot.create_list(:resident, 6)}
  let(:route) { FactoryBot.create(:route, residents: residents) }
  
  it 'can have residents' do
    expect(residents).to eq(residents)
  end
  
end
