# frozen_string_literal: true

class Map
  attr_reader :heightmap, :current_position, :visited, :costs, :lowest_path

  ADJACENTS = [Vector[-1, 0], Vector[0, -1], Vector[1, 0], Vector[0, 1]].freeze

  def initialize(heightmap:, initial_position: nil)
    @heightmap = heightmap
    @visited = []
    @costs = {}
    @initial_position = initial_position || @heightmap.index('S')

    @heightmap[*target_position] = 25
    @heightmap[*@heightmap.index('S')] = 0
  end

  def process
    @lowest_path = generate_path(initial_position, target_position)

    self
  end

  def bad_starting_position?
    possible_movements(@initial_position, @visited).all? { @heightmap[*_1].zero? }
  end

  private

  # https://github.com/aurelienblais/AoC-2021/blob/main/15/part-two/puzzle.rb#L44
  def generate_path(source_node, target_node)
    queue = [[0, source_node]]

    until queue.empty?
      cost, node = queue.shift
      return cost if node == target_node
      next if @visited.include? node

      @visited << node

      possible_movements(node, @visited).each do |neighbour|
        current_cost = cost + 1
        neighbour_min_cost = @costs[neighbour] || Float::INFINITY
        next unless current_cost < neighbour_min_cost

        @costs[neighbour] = current_cost
        queue << [current_cost, neighbour]
        queue.sort_by! { _1[0] }
      end
    end

    Float::INFINITY
  end

  def initial_position
    @initial_position ||= @heightmap.index('S')
  end

  def target_position
    @target_position ||= @heightmap.index('E')
  end

  def valid_movement?(source, target)
    return false if target.any?(&:negative?) || @heightmap[*target].nil?
    return true if @heightmap[*target].zero?

    @heightmap[*source] + 1 == @heightmap[*target] ||
      @heightmap[*source] >= @heightmap[*target]
  end

  def possible_movements(source, visited_elements)
    source_vector = Vector[*source]
    ADJACENTS.map { (source_vector + _1).to_a }
             .reject { visited_elements.include?(_1) }
             .select { valid_movement?(source, _1) }
  end

  def finished?(position)
    position == target_position
  end
end
