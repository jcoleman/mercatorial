class Mercatorial::GoogleMapsClient
  include HTTParty
  base_uri "http://maps.googleapis.com/maps/api"
  format :json

  def self.encode_location(location)
    case location
    when String
      location
    when Hash
      if location[:latitude] && location[:longitude]
        "#{location[:latitude].to_s.strip},#{location[:longitude].to_s.strip}"
      else
        [
          location[:name],
          location[:address],
          location[:city],
          ([
            location[:state_province],
            location[:postal_code],
            location[:country],
          ].find_all { |it| it.present? }.join(' ')),
        ].find_all { |it| it.present? }.join(', ')
      end
    else
      if location.respond_to?(:latitude) && location.respond_to?(:longitude)
        "#{location.latitude.to_s.strip},#{location.longitude.to_s.strip}"
      else
        raise ArgumentError, "Mercatorial expects locations to be passed as either strings or hashes or respond to address_for_geocoding."
      end
    end
  end

  def self.encode_locations(locations)
    locations.collect do |location|
      self.encode_location(location)
    end
  end

  def initialize
  end

  def directions(locations)
    encoded_locations = self.class.encode_locations(locations)
    params = {
      :origin => encoded_locations[0],
      :destination => encoded_locations[-1],
      :sensor => false,
    }
    if encoded_locations.size > 2
      params[:waypoints] = encoded_locations[1..-2].join('|')
    end
    response = self.class.get("/directions/json", :query => params)
    Mercatorial::DirectionsResponse.new(response.parsed_response)
  end

  def distance_matrix(origins, destinations)
    encoded_origins = self.class.encode_locations(origins)
    encoded_destinations = self.class.encode_locations(destinations)
    params = {
      :origins => encoded_origins.join('|'),
      :destinations => encoded_destinations.join('|'),
      :sensor => false,
    }
    response = self.class.get("/distancematrix/json", :query => params)
    Mercatorial::DistanceMatrixResponse.new(response.parsed_response)
  end

  def geocode(location)
    params = {
      :address => self.class.encode_location(location),
      :sensor => false,
    }
    response = self.class.get("/geocode/json", :query => params)
    Mercatorial::GeocodeResponse.new(response.parsed_response)
  end

end
