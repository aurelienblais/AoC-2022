# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'rock_paper_scissor'

class Puzzle < BasePuzzle
  attr_reader :rounds

  def perform
    @rounds = @data.map { RockPaperScissor.new(tuple: _1) }

    # -- Part One
    pp @rounds.sum(&:part_one_score)

    # -- Part Two
    pp @rounds.sum(&:part_two_score)
  end
end

Puzzle.new(file: '02/input.txt').perform
