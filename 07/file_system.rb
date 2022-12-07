# frozen_string_literal: true

require_relative 'command'
require_relative 'directory'
require_relative 'file'

class FileSystem
  attr_reader :directories, :inputs, :parsed_inputs, :cursor

  def initialize(inputs:)
    @inputs = inputs
    @directories = { '/' => Directory.new }
  end

  def perform
    parse_inputs
    process

    self
  end

  def directories_size
    return @directories_size if defined?(@directories_size)

    @directories_size = Hash.new { 0 }

    @directories.map do |path, dir|
      directories_size['/'] += dir.size

      current_path = ''
      path.split('/').reject(&:empty?).each do |elem|
        current_path = "#{current_path}/#{elem}"
        directories_size[current_path] += dir.size
      end
    end

    @directories_size
  end

  private

  def parse_inputs
    @parsed_inputs = @inputs
                     .slice_before { _1.start_with?('$') }
                     .to_a
  end

  def process
    @parsed_inputs.each do |args|
      command = Command.parse(*args)
      command_output = command.perform
      case command_output[0]
      when :move
        @cursor = command.build_cursor(@cursor, @directories.keys)
        @directories[@cursor] ||= Directory.new
      when :list_files
        command.add_files(@directories[@cursor])
      end
    end
  end
end
