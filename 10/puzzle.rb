# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'cpu'

class Puzzle < BasePuzzle
  def perform
    cpu = Cpu.new(program: @data)

    cpu.process

    # -- Part One
    p((20..cpu.x_history.length).step(40).sum do |idx|
      cpu.x_history[idx - 1] * idx
    end)

    # -- Part Two
    pp(cpu.x_history.map.with_index do |elem, idx|
      (elem - 1..elem + 1).include?(idx % 40) ? '#' : '.'
    end.each_slice(40).to_a.map(&:join))
  end
end

Puzzle.new(file: '10/input.txt').perform
