require 'rails_helper'

describe 'Location poro' do
  before :each do
    @response_data = { info: { statuscode: 0, copyright: { text: '© 2021 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif', imageAltText: '© 2021 MapQuest, Inc.' }, messages: [] },
                       options: { maxResults: -1, thumbMaps: true, ignoreLatLngInput: false },
                       results: [{ providedLocation: { location: 'tillamook,or' },
                                   locations: [{ street: '',
                                                 adminArea6: '',
                                                 adminArea6Type: 'Neighborhood',
                                                 adminArea5: 'Tillamook',
                                                 adminArea5Type: 'City',
                                                 adminArea4: 'Tillamook County',
                                                 adminArea4Type: 'County',
                                                 adminArea3: 'OR',
                                                 adminArea3Type: 'State',
                                                 adminArea1: 'US',
                                                 adminArea1Type: 'Country',
                                                 postalCode: '',
                                                 geocodeQualityCode: 'A5XAX',
                                                 geocodeQuality: 'CITY',
                                                 dragPoint: false,
                                                 sideOfStreet: 'N',
                                                 linkId: '282032992',
                                                 unknownInput: '',
                                                 type: 's',
                                                 latLng: { lat: 45.456045, lng: -123.838253 },
                                                 displayLatLng: { lat: 45.456045, lng: -123.838253 },
                                                 mapUrl: 'http://www.mapquestapi.com/staticmap/v5/map?key=v1GRe2i4bownpluDvxVyZ4WVV3SceSPM&type=map&size=225,160&locations=45.456045,-123.838253|marker-sm-50318A-1&scalebar=true&zoom=12&rand=1732692340' }] }] }
  end

  it 'creates location objects' do
    location_poro = Location.new(@response_data)
    expect(location_poro.latitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lat])
    expect(location_poro.longitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lng])
  end

  it 'with invalid city query' do
    response = { info: { statuscode: 400,
                         copyright: { text: '© 2021 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif',
                                      imageAltText: '© 2021 MapQuest, Inc.' },
                         messages: ['Illegal argument from request: Insufficient info for location'] },
                 options: { maxResults: -1, thumbMaps: true, ignoreLatLngInput: false },
                 results: [{ providedLocation: { location: '' }, locations: [] }] }
    location_poro = Location.new(response)
    expect(location_poro.latitude).to be nil
    expect(location_poro.longitude).to be nil
  end

  it 'with city = dasgasfgd' do
    response = { info: { statuscode: 0, copyright: { text: '© 2021 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif', imageAltText: '© 2021 MapQuest, Inc.' }, messages: [] },
                 options: { maxResults: -1, thumbMaps: true, ignoreLatLngInput: false },
                 results: [{ providedLocation: { location: 'dasgasfgd' },
                             locations: [{ street: '',
                                           adminArea6: '',
                                           adminArea6Type: 'Neighborhood',
                                           adminArea5: '',
                                           adminArea5Type: 'City',
                                           adminArea4: '',
                                           adminArea4Type: 'County',
                                           adminArea3: '',
                                           adminArea3Type: 'State',
                                           adminArea1: 'US',
                                           adminArea1Type: 'Country',
                                           postalCode: '',
                                           geocodeQualityCode: 'A1XAX',
                                           geocodeQuality: 'COUNTRY',
                                           dragPoint: false,
                                           sideOfStreet: 'N',
                                           linkId: '282934758',
                                           unknownInput: '',
                                           type: 's',
                                           latLng: { lat: 39.390897, lng: -99.066067 },
                                           displayLatLng: { lat: 39.390897, lng: -99.066067 },
                                           mapUrl: 'http://www.mapquestapi.com/staticmap/v5/map?key=v1GRe2i4bownpluDvxVyZ4WVV3SceSPM&type=map&size=225,160&locations=39.390897,-99.066067|marker-sm-50318A-1&scalebar=true&zoom=2&rand=1201983575' }] }] }
    location_poro = Location.new(response)
    expect(location_poro.latitude).to be nil
    expect(location_poro.longitude).to be nil
  end
end
