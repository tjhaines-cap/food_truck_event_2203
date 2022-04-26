require './lib/event'

describe Event do

  it 'exists and had readable attributes' do
    event = Event.new("South Pearl Street Farmers Market")
    expect(event).to be_a(Event)
    expect(event.name).to eq("South Pearl Street Farmers Market")
    expect(event.food_trucks).to eq([])
  end

end
