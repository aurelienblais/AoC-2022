# frozen_string_literal: true

class Sensor
  attr_reader :x, :y, :closest_beacon

  def initialize(x, y, closest_beacon)
    @x = x
    @y = y
    @closest_beacon = closest_beacon
  end

  def to_s
    'S'
  end

  def distance_to_beacon
    (x - closest_beacon.x).abs + (y - closest_beacon.y).abs
  end
end
