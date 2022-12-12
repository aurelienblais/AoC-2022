# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require 'matrix'
require_relative 'map'

class Puzzle < BasePuzzle
  def perform
    heightmap = Matrix[*@data.map do |row|
      row.chars.map { |c| ('a'..'z').to_a.index(c) || c }
    end]

    map = Map.new(heightmap: heightmap.dup)

    map.process

    # -- Part One
    p map.lowest_path

    # -- Part Two
    possible_paths = []
    map.heightmap.each_with_index do |elem, row, col|
      next unless elem.zero?

      new_map = Map.new(heightmap: heightmap.clone, initial_position: [row, col])
      next if new_map.bad_starting_position? # From 2k+ positions to ~60

      possible_paths << new_map.process.lowest_path
    end

    p possible_paths.min
  end
end

Puzzle.new(file: '12/input.txt').perform
