# frozen_string_literal: true

class InputReader
  attr_reader :file, :content, :parsed_content, :strip

  def initialize(file:, strip: true)
    @file = file
    @strip = strip
  end

  def read
    @content = File.read(@file)
    @parsed_content = @content.split("\n")

    @parsed_content = @parsed_content.map(&:strip) if @strip

    self
  end
end
