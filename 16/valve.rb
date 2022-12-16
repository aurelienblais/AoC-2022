# frozen_string_literal: true

class Valve
  attr_reader :name, :pressure, :neighbors

  def initialize(input:)
    parsed = input.scan(/Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? ([\w(, )?]+)/).to_a[0]

    @name = parsed[0]
    @pressure = parsed[1].to_i
    @neighbors = parsed[2..][0].split(', ')
  end
end
