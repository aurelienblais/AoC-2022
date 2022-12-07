# frozen_string_literal: true

class Command
  attr_reader :command, :argument, :output

  def initialize(command, argument, *output)
    @command = command
    @argument = argument
    @output = output
  end

  def self.parse(command, *output)
    pcommand, pargument = command.gsub('$ ', '').split

    Object.const_get(_command.capitalize).new(pcommand, pargument, output)
  end
end

require_relative 'cd'
require_relative 'ls'
