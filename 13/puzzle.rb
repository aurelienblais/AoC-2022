# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'packet_comparer'

class Puzzle < BasePuzzle
  def perform
    packets = @data.reject(&:empty?)
                   .map { eval(_1) }

    # -- Part One
    ordered_packets = packets.each_slice(2).map.with_index do |sub, idx|
      PacketComparer.compare(*sub).negative? ? idx + 1 : nil
    end

    p ordered_packets.compact.sum

    # -- Part Two
    packets << [[2]]
    packets << [[6]]

    sorted_packets = PacketComparer.sort(packets.compact.dup)

    p (sorted_packets.index([[2]]) + 1) * (sorted_packets.index([[6]]) + 1)
  end
end

Puzzle.new(file: '13/input.txt').perform
