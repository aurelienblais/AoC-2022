# frozen_string_literal: true

require_relative 'command'

class Ls < Command
  def perform(file_system)
    @output[0].map do |row|
      splitted = row.split
      next if splitted[0] == 'dir'

      file_system.add_file! File.new(*splitted.reverse)
    end
  end
end
