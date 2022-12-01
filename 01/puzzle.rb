# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'elf'

class Puzzle < BasePuzzle
  def perform
    elves = []
    splitted_datas.each_with_index do |k, idx|
      elves << Elf.new(position: idx, items: k)
    end

    pp '-- Part one'
    pp elves.max_by(&:calories).calories

    pp ' -- Part two'
    pp elves.sort_by(&:calories)[-3..].sum(&:calories)
  end

  private

  def splitted_datas
    @splitted_datas ||= @data.map(&:to_i)
                             .chunk(&:zero?)
                             .to_a
                             .reject { |k, _| k }
                             .map { |_, v| v }
  end
end

Puzzle.new(file: '01/input.txt').perform
