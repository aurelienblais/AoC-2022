# frozen_string_literal: true

require 'matrix'

class Cave
  attr_reader :beacons, :sensors, :beacon_less_areas

  def initialize(data:)
    parsed_data = parse_input(data: data)

    @beacons = []
    @sensors = []
    @beacon_less_areas = {}

    parsed_data.each do |sensor, beacon|
      beacon = Beacon.new(beacon[0], beacon[1])
      sensor = Sensor.new(sensor[0], sensor[1], beacon)

      @sensors << sensor
      @beacons << beacon
    end
  end

  def process
    @sensors.each do |point|
      dist = point.distance_to_beacon
      (-dist..dist).each do |y|
        next if (point.y + y).negative? || (point.y + y) > 4_000_000

        range_size = ((2 * dist.abs) + 1) - (y.abs * 2)
        next if range_size <= 0

        @beacon_less_areas[point.y + y] ||= []
        @beacon_less_areas[point.y + y] << (point.x - (range_size / 2)..point.x + (range_size / 2))
      end
    end
  end

  private

  def parse_input(data:)
    data.map do |row|
      row.split(':').map { |r| r.scan(/(.\d+)/).flatten.map { _1.gsub('=', '').to_i } }
    end
  end
end
