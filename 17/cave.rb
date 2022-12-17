# frozen_string_literal: true

require 'matrix'

class Cave
  attr_reader :layout, :jets, :current_shape, :current_jet, :falling_rock, :rock_count, :next

  ROCKS = [
    [(0..3)],
    [
      (1..1),
      (0..2),
      (1..1)
    ],
    [
      (0..2),
      (2..2),
      (2..2)
    ],
    [
      (0..0),
      (0..0),
      (0..0),
      (0..0)
    ],
    [
      (0..1),
      (0..1)
    ]
  ].freeze

  def initialize(jets:)
    @jets = jets.chars
    @layout = []
    @current_shape = 0
    @current_jet = 0
    @falling_rock = false
    @rock_count = 0
  end

  def process
    while @rock_count < 2022 || @falling_rock
      add_rock unless @falling_rock

      if @next == :jet
        jet_move
      else
        rock_fall
      end
    end
  end

  def to_s
    @layout.reverse.map do |row|
      out = '.......'.dup
      row&.each do |elem|
        out.chars.each_with_index do |_c, idx|
          if elem[:range].include?(idx)
            out[idx] = elem[:falling] ? '@' : '#'
          end
        end
      end
      out
    end.join("\n")
  end

  def highest_rock
    return 3 if @rock_count.zero?

    max_idx = 0
    (0..@layout.size - 1).each do |idx|
      max_idx = idx unless @layout[idx].empty?
    end
    max_idx + 4
  end

  private

  def add_rock
    rock = ROCKS[@current_shape]
    @current_shape = (@current_shape + 1) % ROCKS.size
    @next = :jet

    height = highest_rock
    rock.each_with_index do |rock_row, idx|
      @layout[height + idx] ||= []
      @layout[height + idx] << { falling: true, range: offset_range(rock_row.dup, 2) }
    end
    @rock_count += 1
    @falling_rock = true
  end

  def jet_move
    @next = :fall
    rock = moving_rock

    jet = @jets[@current_jet]
    @current_jet = (@current_jet + 1) % @jets.size

    return if rock.any? do |x, y|
      if jet == '<'
        (@layout[x][y][:range].min - 1).negative? || @layout[x].reject { _1[:falling] }.any? { _1[:range].include?(@layout[x][y][:range].min - 1) }
      else
        @layout[x][y][:range].max + 1 > 6 || @layout[x].reject { _1[:falling] }.any? { _1[:range].include?(@layout[x][y][:range].max + 1) }
      end
    end

    rock.each do |x, y|
      @layout[x][y][:range] = offset_range(@layout[x][y][:range], jet == '<' ? -1 : 1)
    end
  end

  def rock_fall
    rock = moving_rock
    @next = :jet

    if should_stop?(rock)
      rock.each do |row, col|
        @layout[row][col][:falling] = false
      end
      @falling_rock = false
      return
    end

    rock.each do |row, col|
      elem = @layout[row][col]
      @layout[row].delete_at(col)
      @layout[row - 1] ||= []
      @layout[row - 1] << elem
    end
  end

  def moving_rock
    @layout.map.with_index do |row, idx|
      next if row.nil?
      next unless (elem = row.find { _1[:falling] })

      [idx, row.index(elem)]
    end.compact
  end

  def should_stop?(rock)
    rock.any? do |row, col|
      return true if row.zero?
      return false if @layout[row - 1].nil? || @layout[row - 1].empty?

      @layout[row - 1].reject { _1[:falling] }.any? { _1[:range].include?(@layout[row][col][:range].min) || _1[:range].include?(@layout[row][col][:range].max) }
    end
  end

  def offset_range(range, offset)
    (range.min + offset..range.max + offset)
  end
end
