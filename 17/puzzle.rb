# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'cave'

class Puzzle < BasePuzzle
  def perform
    cave = Cave.new(jets: @data[0])

    cave.process

    p [cave.rock_count, cave.highest_rock - 3]
  end
end

Puzzle.new(file: '17/input.txt').perform
