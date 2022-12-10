# frozen_string_literal: true

class Cpu
  attr_reader :program, :current_x, :cursor, :x_history

  def initialize(program:)
    @program   = program.map(&:split)
    @current_x = 1
    @cursor    = 0
    @x_history = []
  end

  def process
    execute_program
  end

  def signal_strength
    (20..@x_history.length).step(40).sum do |idx|
      @x_history[idx - 1] * idx
    end
  end

  def display_crt_output
    puts (@x_history.map.with_index do |elem, idx|
      (elem - 1..elem + 1).include?(idx % 40) ? '#' : '.'
    end).each_slice(40).map(&:join).join("\n")
  end

  private

  def execute_program
    @program.each do |command|
      increment_and_store(0)
      increment_and_store(command[1]) if command[0] == 'addx'
    end
  end

  def increment_and_store(val)
    @x_history[@cursor] = @current_x
    @current_x          += val.to_i
    @cursor             += 1
  end
end
