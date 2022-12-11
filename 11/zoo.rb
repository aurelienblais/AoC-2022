# frozen_string_literal: true

require_relative 'monkey'

class Zoo
  attr_reader :monkeys, :relief

  def initialize(input:, relief:)
    @monkeys = input.chunk(&:empty?)
                    .reject { _1[0] }
                    .map { Monkey.new(monkey: _1[1], zoo: self) }
    @relief = relief
  end

  def process(round:)
    round.times do
      @monkeys.each { |monkey| monkey.process(lcm: least_common_multiple) }
    end
  end

  def throw_item(item:, monkey:)
    @monkeys[monkey].add_item item
  end

  def monkeys_business
    @monkeys.map(&:inspections_count)
            .sort
            .last(2)
            .reduce(&:*)
  end

  private

  def least_common_multiple
    @least_common_multiple ||= @monkeys.map(&:test_value).reduce(&:lcm)
  end
end
