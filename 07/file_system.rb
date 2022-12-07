# frozen_string_literal: true

require_relative 'command'
require_relative 'directory'
require_relative 'file'

class FileSystem
  attr_reader :directories, :inputs, :parsed_inputs
  attr_accessor :cursor

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

  def create_directory!
    @directories[@cursor] ||= Directory.new
  end

  def add_file!(file)
    @directories[@cursor].add_file!(file)
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
      command.perform(self)
    end
  end
end
