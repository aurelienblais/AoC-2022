# frozen_string_literal: true

require 'matrix'

class Cave
  attr_reader :layout, :x_min, :moving_sand, :voided, :sand_count, :offset_x, :prev_moving_sand

  def initialize(rocks:, floor: false)
    rocks = parse_coordinates(rocks)
    reduce_coordinates(rocks)

    max_y = rocks.flatten(1).max_by { _1[1] }[1] + 1
    max_y += 2 if floor

    @offset_x = floor ? 200 : 0

    max_x = rocks.flatten(1).max_by { _1[0] }[0] + 1 - @x_min
    @layout = Matrix.build(
      max_y,
      max_x + (2 * @offset_x)
    ) { '.' }

    rocks.each do |rock_walls|
      rock_walls.each_cons(2) do |starting, ending|
        range_for(starting[0] - @x_min, ending[0] - @x_min).each do |y|
          range_for(starting[1], ending[1]).each do |x|
            @layout[x, y + @offset_x] = '#'
          end
        end
      end
    end

    (0..@layout.column_count - 1).each { @layout[@layout.row_count - 1, _1] = '#' } if floor

    @layout[0, 500 - @x_min + @offset_x] = '+'
    @sand_count = 0
  end

  def process
    until @voided
      @moving_sand = [0, 500 - @x_min + @offset_x] if @moving_sand.nil?
      move_sand(@moving_sand)
    end
  end

  def to_s
    @layout.to_a.map(&:join).join("\n")
  end

  private

  def parse_coordinates(rocks)
    rocks.map do |wall|
      wall.split(' -> ').map { _1.split(',').map(&:to_i) }
    end
  end

  def reduce_coordinates(rocks)
    @x_min = rocks.flatten(1).min_by { _1[0] }[0]
  end

  def range_for(starting, ending)
    starting < ending ? starting.upto(ending) : starting.downto(ending)
  end

  def move_sand(current_position)
    if @layout[current_position[0] + 1, current_position[1]] == '.'
      @moving_sand = [current_position[0] + 1, current_position[1]]
    elsif @layout[current_position[0] + 1, current_position[1] - 1] == '.'
      @moving_sand = [current_position[0] + 1, current_position[1] - 1]
    elsif @layout[current_position[0] + 1, current_position[1] + 1] == '.'
      @moving_sand = [current_position[0] + 1, current_position[1] + 1]
    elsif (current_position[1] - 1).negative?
      @moving_sand = nil
    elsif current_position[0] + 1 == @layout.row_count
      @voided = true
    else
      @voided = @prev_moving_sand == current_position
      @prev_moving_sand = current_position
      @sand_count += 1
      @layout[*current_position] = 'o'
      @moving_sand = nil
    end
  end
end
