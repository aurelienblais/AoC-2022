# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'pair'

class Puzzle < BasePuzzle
  attr_reader :pairs

  def perform
    @pairs = @data.map { Pair.new(pairs: _1) }

    # -- Part One
    pp @pairs.map(&:fully_contained_by_other?).count(true)

    # -- Part Two
    pp @pairs.map(&:overlap?).count(true)
  end
end

Puzzle.new(file: '04/input.txt').perform
