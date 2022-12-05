# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'stack'
require_relative 'instruction'

class Puzzle < BasePuzzle
  attr_reader :raw_stacks, :raw_instructions, :stacks, :instructions

  def initialize(file:)
    super(file: file, strip: false)

    @stacks = []
    @instructions = []
  end

  def perform
    parse_data
    parse_stacks
    parse_instructions

    process(move_groups: false)
    process(move_groups: true)
  end

  private

  def parse_data
    @raw_stacks, @raw_instructions = @data
                                     .chunk { _1 == '' }
                                     .to_a
                                     .select { _1[0] == false }
                                     .map { _1[1] }
  end

  def parse_stacks
    @raw_stacks.each do |row|
      column = -1
      row.chars.each_slice(4) do |item|
        column += 1
        next if item[0] == ' '

        @stacks[column] ||= Stack.new
        @stacks[column].push item[1]
      end
    end

    @stacks.each(&:reverse!)
  end

  def parse_instructions
    @instructions = @raw_instructions.map { Instruction.new(prompt: _1) }
  end

  def process(move_groups: false)
    stacks = @stacks.map { Stack.new(items: _1.items) }

    @instructions.each { _1.perform(stacks: stacks, keep_ordered: move_groups) }

    puts stacks.map(&:last).join
  end
end

Puzzle.new(file: '05/input.txt').perform
