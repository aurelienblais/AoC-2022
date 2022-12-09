# frozen_string_literal: true

class Rope
  attr_reader :visited_positions, :movements, :knots

  def initialize(movements:, knots:)
    @knots = knots.times.map { [0, 0] }
    @visited_positions = [[0, 0]]
    @movements = movements.map { |m| m.split.tap { _1[1] = _1[1].to_i } }
  end

  def process
    @movements.each { move_head _1 }

    self
  end

  private

  def move_head(movement)
    movement[1].times do
      process_head_movement movement[0]

      move_following 0, 1
    end
  end

  def process_head_movement(direction)
    case direction
    when 'U'
      @knots[0][1] += 1
    when 'D'
      @knots[0][1] -= 1
    when 'L'
      @knots[0][0] -= 1
    when 'R'
      @knots[0][0] += 1
    end
  end

  def move_following(head_idx, tail_idx)
    head, tail = @knots[head_idx..tail_idx]

    process_move_following(head, tail)

    if tail_idx == @knots.size - 1
      @visited_positions << tail.dup
    else
      move_following head_idx + +1, tail_idx + 1
    end
  end

  def process_move_following(head, tail)
    delta_x = head[0] - tail[0]
    delta_y = head[1] - tail[1]
    return unless delta_x.abs > 1 || delta_y.abs > 1

    tail[0] += (delta_x.positive? ? 1 : -1) unless delta_x.zero?
    tail[1] += (delta_y.positive? ? 1 : -1) unless delta_y.zero?
  end
end
