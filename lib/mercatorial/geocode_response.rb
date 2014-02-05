class Mercatorial::GeocodeResponse < Mercatorial::GoogleMapsResponse

  class ResponseResult
    attr_reader :json_result
    attr_reader :address_components_by_type

    def initialize(parsed_result_json)
      @json_result = parsed_result_json

      address_components_by_type = {}
      self.json_result['address_components'].each do |address_component|
        address_component['types'].each do |type|
          address_components_by_type[type] = address_component
        end
      end
      @address_components_by_type = address_components_by_type
    end

    def name
      self.json_result['name']
    end

    def address
      [
        self.address_components_by_type['street_number'],
        self.address_components_by_type['route']
      ].find_all { |component| component }
       .collect { |component| component['short_name'] }
       .join(' ')
    end

    def city
      locality = self.address_components_by_type['locality']
      locality ? locality['short_name'] : nil
    end

    def state_province
      administrative_area_level_1 = self.address_components_by_type['administrative_area_level_1']
      administrative_area_level_1 ? administrative_area_level_1['short_name'] : nil
    end

    def country
      country = self.address_components_by_type['country']
      country ? country['short_name'] : nil
    end

    def postal_code
      postal_code = self.address_components_by_type['postal_code']
      postal_code ? postal_code['postal_code'] : nil
    end

    def latitude_and_longitude
      geometry = self.json_result['geometry']
      if geometry
        location = geometry['location']
        if location
          [location['lat'], location['lng']]
        end
      end
    end

    def international_phone_number
      self.json_result['international_phone_number']
    end

    def location_types
      self.json_result['types']
    end
  end

  attr_reader :json_results

  def initialize(parsed_json={})
    super(parsed_json)
    @json_results = parsed_json['results']
  end

  def results
    if defined?(@results)
      @results
    else
      results = self.json_results.collect do |json_result|
        ResponseResult.new(json_result)
      end
      @results = results
    end
  end

end
