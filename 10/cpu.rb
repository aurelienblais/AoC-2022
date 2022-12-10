# frozen_string_literal: true

class Cpu
  attr_reader :program, :execution_pile, :x, :x_history

  def initialize(program:)
    @program = program.map(&:split)
    @execution_pile = []
    @x = 1
    @x_history = []

    generate_execution_pile
  end

  def process
    execute_pile
  end

  private

  def generate_execution_pile
    cursor = 0

    @program.each do |command|
      @execution_pile[cursor] = [:noop]
      cursor += 1
      if command[0] == 'addx'
        @execution_pile[cursor] = [:addx, command[1].to_i]
        cursor += 1
      end
    end
  end

  def execute_pile
    @execution_pile.each_with_index do |instruction, idx|
      @x_history[idx] = @x
      next if instruction[0] == :noop

      @x += instruction[1]
    end
  end
end
