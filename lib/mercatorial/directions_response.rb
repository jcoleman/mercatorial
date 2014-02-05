class Mercatorial::DirectionsResponse < Mercatorial::GoogleMapsResponse

  attr_reader :routes

  def initialize(parsed_json={})
    super(parsed_json)
    @routes = parsed_json['routes']
  end

  def leg_distances
    if defined? @leg_distances
      @leg_distances
    else
      distances = @routes.first['legs'].collect do |leg|
        leg['distance']['value']
      end
      @leg_distances = distances
    end
  end

  def leg_durations
    if defined? @leg_durations
      @leg_durations
    else
      durations = @routes.first['legs'].collect do |leg|
        leg['duration']['value']
      end
      @leg_distances = durations
    end
  end

  def total_distance
    if defined?(@total_distance)
      @total_distance
    else
      @total_distance = self.leg_distances.sum
    end
  end

  def total_duration
    if defined?(@total_duration)
      @total_duration
    else
      @total_duration = self.leg_durations.sum
    end
  end

end
