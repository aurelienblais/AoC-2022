# frozen_string_literal: true

require_relative 'command'

class Ls < Command
  def perform
    [:list_files]
  end

  def add_files(directory)
    files = @output[0].map do |row|
      splitted = row.split
      next if splitted[0] == 'dir'

      File.new(*splitted.reverse)
    end.compact

    directory.files.concat(files)
  end
end
