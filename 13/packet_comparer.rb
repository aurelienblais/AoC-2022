# frozen_string_literal: true

class PacketComparer
  def self.compare(left, right)
    if left.is_a?(Array) && right.is_a?(Array)
      return 0 if left == right

      left.length.times do |idx|
        return 1 if right[idx].nil?
        next if (mem = compare(left[idx], right[idx])).zero?

        return mem
      end

      right.length > left.length ? -1 : 0
    elsif left.is_a?(Integer) && right.is_a?(Integer)
      left - right
    else
      compare(Array(left), Array(right))
    end
  end

  def self.sort(packets)
    packets.length.times do |i|
      (0..packets.length - i - 1).each do |j|
        packets[j], packets[j + 1] = packets[j + 1], packets[j] if compare(packets[j], packets[j + 1]).positive?
      end
    end

    packets.compact
  end
end
