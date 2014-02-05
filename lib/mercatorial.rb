require "mercatorial/version"

module Mercatorial

  def self.google_maps_client
    @google_maps_client ||= Mercatorial::GoogleMapsClient.new
  end

  def self.directions(locations)
    self.google_maps_client.directions(locations)
  end

  def self.distance_matrix(origins, destinations)
    self.google_maps_client.distance_matrix(origins, destinations)
  end

  def self.geocode(address)
    self.google_maps_client.geocode(address)
  end

end

require 'mercatorial/google_maps_client'
require 'mercatorial/google_maps_response'
require 'mercatorial/directions_response'
require 'mercatorial/distance_matrix_response'
require 'mercatorial/geocode_response'
