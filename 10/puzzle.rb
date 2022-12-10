# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'cpu'

class Puzzle < BasePuzzle
  def perform
    cpu = Cpu.new(program: @data)

    cpu.process

    # -- Part One
    p cpu.signal_strength

    # -- Part Two
    cpu.display_crt_output
  end
end

Puzzle.new(file: '10/input.txt').perform
