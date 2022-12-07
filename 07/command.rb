# frozen_string_literal: true

class Command
  attr_reader :command, :argument, :output

  def initialize(command, argument, *output)
    @command = command
    @argument = argument
    @output = output
  end

  def self.parse(command, *output)
    parsed_command, parsed_argument = command.gsub('$ ', '').split

    Object.const_get(parsed_command.capitalize)
          .new(parsed_command, parsed_argument, output)
  end
end

require_relative 'cd'
require_relative 'ls'
