# frozen_string_literal: true

class File
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end
end
