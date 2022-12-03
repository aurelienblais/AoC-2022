# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'rucksack'

class Puzzle < BasePuzzle
  attr_reader :rucksacks

  def perform
    @rucksacks = @data.map { Rucksack.new(items: _1) }

    # -- Part One
    pp @rucksacks.sum(&:priority)

    # -- Part Two
    @groups = @rucksacks.each_slice(3).to_a

    elves_groups = @groups.flat_map do |group|
      group.map(&:items).reduce(&:&)[0].priority
    end

    pp elves_groups.sum
  end
end

Puzzle.new(file: '03/input.txt').perform
