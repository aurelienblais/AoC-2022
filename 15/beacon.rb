# frozen_string_literal: true

class Beacon
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    'B'
  end
end
