# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'packet_finder'

class Puzzle < BasePuzzle
  def perform
    packet_finder = PacketFinder.new(string: @data[0], packet_length: 4).perform

    # -- Part One
    pp packet_finder.processed_characters

    packet_finder = PacketFinder.new(string: @data[0], packet_length: 14).perform

    # -- Part Two
    pp packet_finder.processed_characters
  end
end

Puzzle.new(file: '06/input.txt').perform
