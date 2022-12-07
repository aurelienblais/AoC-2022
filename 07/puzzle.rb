# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'file_system'

class Puzzle < BasePuzzle
  def perform
    file_system = FileSystem.new(inputs: @data).perform

    # -- Part One
    pp file_system.directories_size
                  .reject { |_, v| v > 100_000 }
                  .sum { |_, v| v }

    # -- Part Two
    total_needed = 70_000_000 - file_system.directories_size['/']
    required_space = 30_000_000
    place_to_free = required_space - total_needed

    pp file_system.directories_size
                  .reject { |_, v| v < place_to_free }
                  .min_by { |_, v| v }[1]
  end
end

Puzzle.new(file: '07/input.txt').perform
