class Mercatorial::DistanceMatrixResponse < Mercatorial::GoogleMapsResponse

  class ResponseElement
    attr_reader :status
    attr_reader :success
    attr_reader :element

    def initialize(parsed_element_json)
      @status = parsed_element_json['status']
      @success = (@status == 'OK')
      @element = parsed_element_json
    end

    def distance
      self.element['distance']['value']
    end

    def duration
      self.element['duration']['value']
    end
  end

  attr_reader :rows

  def initialize(parsed_json={})
    super(parsed_json)
    @rows = parsed_json['rows']
  end

  def elements
    if defined? @elements
      @elements
    else
      elements = []
      self.rows.each do |row|
        row['elements'].each do |element|
          elements << ResponseElement.new(element)
        end
      end
      @elements = elements
    end
  end

end
