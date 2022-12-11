# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'zoo'

class Puzzle < BasePuzzle
  def perform
    zoo = Zoo.new(input: @data, relief: true)

    zoo.process(round: 20)

    p zoo.monkeys_business

    zoo = Zoo.new(input: @data, relief: false)

    zoo.process(round: 10_000)

    p zoo.monkeys_business
  end
end

Puzzle.new(file: '11/input.txt').perform
