# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'valve'
require_relative 'part_one'

class Puzzle < BasePuzzle
  def perform
    PartOne.new(data: @data).process
  end
end

Puzzle.new(file: '16/input.txt').perform
