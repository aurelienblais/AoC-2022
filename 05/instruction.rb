# frozen_string_literal: true

class Instruction
  attr_reader :count, :source, :target

  def initialize(prompt:)
    @count, @source, @target = prompt
                               .split
                               .map(&:to_i)
                               .reject(&:zero?)
  end

  def perform(stacks:, keep_ordered: false)
    reminder = stacks[@source - 1].pop(count)
    reminder.reverse! unless keep_ordered
    stacks[@target - 1].push reminder
  end
end
