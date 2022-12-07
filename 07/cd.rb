# frozen_string_literal: true

require_relative 'command'

class Cd < Command
  def perform
    [:move, @argument]
  end

  def build_cursor(current_cursor, _dir_tree)
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
