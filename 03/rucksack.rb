# frozen_string_literal: true

require_relative 'item'

class Rucksack
  attr_reader :compartments

  def initialize(items:)
    @compartments = items
                    .chars
                    .map { Item.new(name: _1) }
                    .each_slice(items.length / 2)
                    .to_a
  end

  def priority
    common_element.priority
  end

  def items
    @compartments.reduce(&:concat)
  end

  private

  def common_element
    (@compartments[0] & @compartments[1])[0]
  end
end
