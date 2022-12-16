# frozen_string_literal: true

class PartOne
  attr_reader :valves, :costs, :pressured_valves

  def initialize(data:)
    @valves = {}

    data.each do |row|
      valve               = Valve.new(input: row)
      @valves[valve.name] = valve
    end

    process_valves
  end

  def process
    p part_one('AA', 30)
  end

  private

  def process_valves
    @pressured_valves = @valves.select { _2.name == 'AA' || _2.pressure.positive? }.keys
    @costs = {}

    @valves.each do |k, _|
      next unless @pressured_valves.include?(k)

      current = [k]
      next_valves = []
      cost = 0
      @costs[[k, k]] = 0

      until current.empty?
        cost += 1

        current.each do |valve|
          @valves[valve].neighbors.each do |next_valve|
            unless @costs.include?([k, next_valve])
              @costs[[k, next_valve]] = cost
              next_valves << next_valve
            end
          end
        end

        current = next_valves
        next_valves = []
      end
    end
  end

  def part_one(current, time, seen = [], targets = @pressured_valves)
    seen << current
    best_pressure = 0

    targets.reject { seen.include?(_1) }.each do |target|
      time_left = time - @costs[[current, target]] - 1
      next unless time_left.positive?

      pressure = @valves[target].pressure * time_left
      pressure += part_one(target, time_left, seen.dup, targets)
      best_pressure = pressure if pressure > best_pressure
    end

    best_pressure
  end
end
