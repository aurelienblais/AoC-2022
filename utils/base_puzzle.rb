# frozen_string_literal: true

require_relative 'input_reader'
require 'debug'

class BasePuzzle
  attr_reader :data

  def initialize(file:)
    input_reader = InputReader.new(file: file).read
    @data = input_reader.parsed_content
  end

  def perform
    puts @data
  end
end
