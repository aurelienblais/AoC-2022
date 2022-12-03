# frozen_string_literal: true

class Item
  attr_reader :name

  ALPHABET = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  def initialize(name:)
    @name = name
  end

  def priority
    ALPHABET.index(name) + 1
  end

  def eql?(other)
    name == other.name
  end

  def hash
    name.hash
  end
end
