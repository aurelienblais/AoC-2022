# frozen_string_literal: true

require_relative 'command'

class Cd < Command
  def perform(file_system)
    file_system.cursor = build_cursor(file_system.cursor)
    file_system.create_directory!
  end

  private

  def build_cursor(current_cursor)
    return '/' if @argument == '/'

    current_cursor = '' if current_cursor == '/'

    if @argument == '..'
      '/' + current_cursor.split('/')
                          .reject(&:empty?)[0..-2]
                          .join('/')
    else
      current_cursor + "/#{@argument}"
    end
  end
end
