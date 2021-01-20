require 'rails_helper'

describe 'Photo poro' do
  before :each do
    @location = 'denver,co'
    @response_data = { route: { hasTollRoad: false,
                                hasBridge: true,
                                boundingBox: { lr: { lng: -104.858307, lat: 39.738453 },
                                               ul: { lng: -123.838249, lat: 45.615078 } },
                                distance: 1330.5331,
                                hasTimedRestriction: false,
                                hasTunnel: true,
                                locations: [{ dragPoint: false,
                                              displayLatLng: { lng: -123.838249, lat: 45.456043 },
                                              adminArea4: 'Tillamook County',
                                              adminArea5: 'Tillamook',
                                              postalCode: '',
                                              adminArea1: 'US',
                                              adminArea3: 'OR',
                                              type: 's',
                                              sideOfStreet: 'N',
                                              geocodeQualityCode: 'A5XAX',
                                              adminArea4Type: 'County',
                                              linkId: 1_250_248,
                                              street: '',
                                              adminArea5Type: 'City',
                                              geocodeQuality: 'CITY',
                                              adminArea1Type: 'Country',
                                              adminArea3Type: 'State',
                                              latLng: { lng: -123.838253, lat: 45.456045 } },
                                            { dragPoint: false,
                                              displayLatLng: { lng: -104.984856, lat: 39.738453 },
                                              adminArea4: 'Denver County',
                                              adminArea5: 'Denver',
                                              postalCode: '',
                                              adminArea1: 'US',
                                              adminArea3: 'CO',
                                              type: 's',
                                              sideOfStreet: 'N',
                                              geocodeQualityCode: 'A5XAX',
                                              adminArea4Type: 'County',
                                              linkId: 40_287_819,
                                              street: '',
                                              adminArea5Type: 'City',
                                              geocodeQuality: 'CITY',
                                              adminArea1Type: 'Country',
                                              adminArea3Type: 'State',
                                              latLng: { lng: -104.984853, lat: 39.738453 } }],
                                time: 67_447 } }
  end

  it 'creates photo objects' do
    road_trip_poro = RoadTrip.new(@response_data)
    expect(road_trip_poro.start_city).to eq('Tillamook, OR')
    expect(road_trip_poro.end_city).to eq('Denver, CO')
    expect(road_trip_poro.travel_time).to eq('18 hours, 44 minutes')
    expect(road_trip_poro.end_latitude).to eq(@response_data[:route][:locations][1][:latLng][:lat])
    expect(road_trip_poro.end_longitude).to eq(@response_data[:route][:locations][1][:latLng][:lng])
  end

  it 'with invalid params' do
    response = { route: { routeError: { errorCode: 211, message: '' } },
                 info: { statuscode: 611,
                         copyright: { imageAltText: '© 2020 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif',
                                      text: '© 2020 MapQuest, Inc.' },
                         messages: ['At least two locations must be provided.'] } }
    road_trip_poro = RoadTrip.new(response)
    expect(road_trip_poro.start_city).to be nil
    expect(road_trip_poro.end_city).to be nil
    expect(road_trip_poro.travel_time).to be nil
    expect(road_trip_poro.end_latitude).to be nil
    expect(road_trip_poro.end_longitude).to be nil
  end
end
