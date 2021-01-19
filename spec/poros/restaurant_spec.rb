require 'rails_helper'

describe 'Location poro' do
  before :each do
    @response_data = {"id"=>"6kRbrLNIZKZ1fcjgsTFobg",
      "alias"=>"fortune-wok-to-table-denver",
      "name"=>"Fortune Wok to Table",
      "image_url"=>"https://s3-media1.fl.yelpcdn.com/bphoto/aVmP8cWwrCsLWWjwx8wvjg/o.jpg",
      "is_closed"=>false,
      "url"=>
       "https://www.yelp.com/biz/fortune-wok-to-table-denver?adjust_creative=9-SbLCptYcvw7TaCfk_IGQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=9-SbLCptYcvw7TaCfk_IGQ",
      "review_count"=>300,
      "categories"=>[{"alias"=>"chinese", "title"=>"Chinese"}],
      "rating"=>4.5,
      "coordinates"=>{"latitude"=>39.72124, "longitude"=>-104.9543},
      "transactions"=>["delivery"],
      "price"=>"$$",
      "location"=>
       {"address1"=>"2817 E 3rd Ave",
        "address2"=>"",
        "address3"=>"",
        "city"=>"Denver",
        "zip_code"=>"80206",
        "country"=>"US",
        "state"=>"CO",
        "display_address"=>["2817 E 3rd Ave", "Denver, CO 80206"]},
      "phone"=>"+13033217788",
      "display_phone"=>"(303) 321-7788",
      "distance"=>2093.330545587293}
  end

  it 'creates restaurant objects' do
    restaurant_poro = Restaurant.new(@response_data)
    expect(restaurant_poro.name).to eq(@response_data['name'])
    expect(restaurant_poro.address).to eq(@response_data['location']['display_address'])
  end
end
