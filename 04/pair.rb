# frozen_string_literal: true

class Pair
  attr_reader :pairs

  def initialize(pairs:)
    @pairs = pairs.split(',').map { Range.new(*_1.split('-')).to_a }
  end

  def fully_contained_by_other?
    @pairs.any? { _1 == shared_elements }
  end

  def overlap?
    shared_elements.any?
  end

  private

  def shared_elements
    @shared_elements ||= @pairs.reduce(&:&)
  end
end
