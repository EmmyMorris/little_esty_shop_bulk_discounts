require 'spec_helper'

RSpec.describe 'External request' do
  it 'queries FactoryGirl contributors on GitHub' do
    uri = URI("https://date.nager.at/api/v2/NextPublicHolidays/us")

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end
