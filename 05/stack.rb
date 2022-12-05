# frozen_string_literal: true

class Stack
  attr_reader :items

  def initialize(items: [])
    @items = items.dup
  end

  def push(items)
    @items.concat Array(items)
  end

  def pop(count = 1)
    @items.pop(count)
  end

  def reverse!
    @items.reverse!
  end

  def last
    @items.last
  end
end
