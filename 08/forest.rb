# frozen_string_literal: true

require 'matrix'

class Forest
  attr_reader :trees, :visible_trees, :scenic_score

  def initialize(trees:)
    @trees = Matrix[*trees]
  end

  def process
    @visible_trees = @trees.dup
    @scenic_score = @trees.dup

    @visible_trees.each_with_index do |e, row, col|
      @visible_trees[row, col] = visible?(e, row, col)
    end

    @scenic_score.each_with_index do |e, row, col|
      @scenic_score[row, col] = calc_scenic_score(e, row, col)
    end
  end

  private

  def visible?(e, row, col)
    return true if row.zero? || col.zero?
    return true if row == @trees.row_count - 1 || col == @trees.column_count - 1

    left, right = slice_array(@trees.row(row), col)
    return true if left.all? { _1 < e } || right.all? { _1 < e }

    up, down = slice_array(@trees.column(col), row)
    return true if up.all? { _1 < e } || down.all? { _1 < e }

    false
  end

  def calc_scenic_score(e, row, col)
    return 0 if row.zero? || col.zero?
    return 0 if row == @trees.row_count - 1 || col == @trees.column_count - 1

    score = 1

    left, right = slice_array(@trees.row(row), col)
    up, down = slice_array(@trees.column(col), row)

    score *= first_slice_count(left.reverse, e)
    score *= first_slice_count(right, e)

    score *= first_slice_count(up.reverse, e)
    score *= first_slice_count(down, e)

    score
  end

  def slice_array(array, idx)
    [
      array[...idx],
      array[idx + 1...]
    ]
  end

  def first_slice_count(array, e)
    array.slice_when { _1 >= e }.to_a[0].count
  end
end
