# frozen_string_literal: true

class Player
  MAPPINGS = {
    A: :ROCK,
    X: :ROCK,
    B: :PAPER,
    Y: :PAPER,
    C: :SCISSOR,
    Z: :SCISSOR
  }.freeze

  attr_reader :letter

  def initialize(letter:)
    @letter = letter.to_sym
  end

  def shape
    MAPPINGS[@letter]
  end

  def ==(other)
    return letter == other if other.is_a?(Symbol)

    letter == other.letter
  end
end

class RockPaperScissor
  attr_reader :opponent, :player

  RULES = {
    ROCK: :SCISSOR,
    PAPER: :ROCK,
    SCISSOR: :PAPER
  }.freeze

  SHAPE_SCORES = {
    ROCK: 1,
    PAPER: 2,
    SCISSOR: 3
  }.freeze

  OUTPUT_SCORES = {
    LOST: 0,
    DRAW: 3,
    WIN: 6
  }.freeze

  def initialize(tuple:)
    @opponent, @player = tuple.split.map { Player.new(letter: _1) }
  end

  def part_one_score
    OUTPUT_SCORES[part_one_result] + SHAPE_SCORES[@player.shape]
  end

  def part_two_score
    OUTPUT_SCORES[part_two_result] + SHAPE_SCORES[part_two_shape]
  end

  private

  def part_one_result
    return :DRAW if @opponent.shape == @player.shape
    return :WIN if @opponent.shape == RULES[@player.shape]

    :LOST
  end

  def part_two_result
    return :LOST if @player == :X
    return :DRAW if @player == :Y

    :WIN
  end

  def part_two_shape
    case part_two_result
    when :DRAW
      @opponent.shape
    when :WIN
      RULES.find { |_, v| v == @opponent.shape }[0]
    else
      RULES[@opponent.shape]
    end
  end
end
