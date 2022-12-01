# frozen_string_literal: true

class Elf
  attr_reader :position, :items

  def initialize(position:, items:)
    @position = position
    @items = items
  end

  def calories
    @items.sum
  end
end
