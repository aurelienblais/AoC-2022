# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'rope'

class Puzzle < BasePuzzle
  def perform
    rope = Rope.new(movements: @data, knots: 2)

    # -- Part One
    pp rope.process.visited_positions.uniq.count

    rope = Rope.new(movements: @data, knots: 10)

    # -- Part Two
    pp rope.process.visited_positions.uniq.count
  end
end

Puzzle.new(file: '09/input.txt').perform
