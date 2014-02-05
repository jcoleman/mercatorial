class Mercatorial::GoogleMapsResponse

  attr_reader :success
  attr_reader :status
  attr_reader :error_message

  def initialize(parsed_json={})
    @status = parsed_json['status']
    @success = (@status == 'OK')
    unless @success
      @error_message = parsed_json['error_message']
    end
  end

  def success?
    self.success
  end

end
