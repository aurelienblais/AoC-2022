# frozen_string_literal: true

class Directory
  attr_accessor :files, :directories

  def initialize
    @files = []
  end

  def size
    @files.sum(&:size)
  end
end
