class LocationFacade
  class << self
    def city_search(city)
      response = MapquestService.city_search(city)
      Location.new(response)
    end
  end
end