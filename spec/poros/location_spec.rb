require 'rails_helper'

describe 'Location poro' do
  before :each do
    @response_data = File.read('spec/fixtures/location_response.rb')
    # response_data = { info: { statuscode: 0, copyright: { text: '© 2021 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif', imageAltText: '© 2021 MapQuest, Inc.' }, messages: [] },
    #                   options: { maxResults: -1, thumbMaps: true, ignoreLatLngInput: false },
    #                   results: [{ providedLocation: { location: 'tillamook,or' },
    #                               locations: [{ street: '',
    #                                             adminArea6: '',
    #                                             adminArea6Type: 'Neighborhood',
    #                                             adminArea5: 'Tillamook',
    #                                             adminArea5Type: 'City',
    #                                             adminArea4: 'Tillamook County',
    #                                             adminArea4Type: 'County',
    #                                             adminArea3: 'OR',
    #                                             adminArea3Type: 'State',
    #                                             adminArea1: 'US',
    #                                             adminArea1Type: 'Country',
    #                                             postalCode: '',
    #                                             geocodeQualityCode: 'A5XAX',
    #                                             geocodeQuality: 'CITY',
    #                                             dragPoint: false,
    #                                             sideOfStreet: 'N',
    #                                             linkId: '282032992',
    #                                             unknownInput: '',
    #                                             type: 's',
    #                                             latLng: { lat: 45.456045, lng: -123.838253 },
    #                                             displayLatLng: { lat: 45.456045, lng: -123.838253 },
    #                                             mapUrl: 'http://www.mapquestapi.com/staticmap/v5/map?key=v1GRe2i4bownpluDvxVyZ4WVV3SceSPM&type=map&size=225,160&locations=45.456045,-123.838253|marker-sm-50318A-1&scalebar=true&zoom=12&rand=1732692340' }] }] }
  end

  it 'creates location objects' do
    location_poro = Location.new(@response_data)
    expect(location_poro.latitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lat])
    expect(location_poro.longitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lng])
  end
end
