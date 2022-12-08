# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'forest'

class Puzzle < BasePuzzle
  def perform
    forest = Forest.new trees: @data.map { _1.chars.map(&:to_i) }

    forest.process

    # -- Part One
    pp forest.visible_trees.to_a.flatten.count { _1 }

    # -- Part Two
    pp forest.scenic_score.to_a.flatten.max
  end
end

Puzzle.new(file: '08/input.txt').perform
