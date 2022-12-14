# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'cave'

class Puzzle < BasePuzzle
  def perform
    cave = Cave.new(rocks: @data)

    cave.process

    # -- Part One
    p cave.sand_count

    cave = Cave.new(rocks: @data, floor: true)

    cave.process

    # puts cave

    # -- Part Two
    p cave.sand_count - 1
  end
end

Puzzle.new(file: '14/input.txt').perform
