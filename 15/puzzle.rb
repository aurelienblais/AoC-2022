# frozen_string_literal: true

require_relative '../utils/base_puzzle'
require_relative 'sensor'
require_relative 'beacon'
require_relative 'cave'

class Puzzle < BasePuzzle
  def perform
    cave = Cave.new(data: @data)

    # part_one_row = 10
    part_one_row = 2_000_000
    x_beacons = cave.beacons.select { _1.y == part_one_row }.map(&:x)

    cave.process

    # https://stackoverflow.com/a/6018744
    def ranges_overlap?(a, b)
      a.include?(b.begin) || b.include?(a.begin)
    end

    def merge_ranges(a, b)
      [a.begin, b.begin].min..[a.end, b.end].max
    end

    def merge_overlapping_ranges(overlapping_ranges)
      overlapping_ranges.sort_by(&:begin).inject([]) do |ranges, range|
        if !ranges.empty? && ranges_overlap?(ranges.last, range)
          ranges[0...-1] + [merge_ranges(ranges.last, range)]
        else
          ranges + [range]
        end
      end
    end

    # -- Part One

    p merge_overlapping_ranges(cave.beacon_less_areas[part_one_row]).map(&:to_a)
                                                                    .reduce(&:concat)
                                                                    .uniq
                                                                    .reject { x_beacons.include?(_1) }
                                                                    .count

    # -- Part Two
    part_two_limit = 4_000_000
    search_ary = (0..part_two_limit)
    point = nil
    cave.beacon_less_areas.each do |y, arr_x|
      next unless search_ary.include?(y)

      begin
        px = merge_overlapping_ranges(arr_x).reject { _1.min <= search_ary.min && _1.max >= search_ary.max }
                                            .map(&:to_a)
                                            .reduce(&:concat)
                                            .uniq
                                            .select { search_ary.cover?(_1) }

        next if (px.size - 1) >= part_two_limit

        x = (search_ary.to_a - px)[0]

        point = [x, y]
        break
      rescue StandardError
        next
      end
    end

    p (point[0] * 4_000_000) + point[1]
  end
end

Puzzle.new(file: '15/input.txt').perform
