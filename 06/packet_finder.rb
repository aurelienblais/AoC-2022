# frozen_string_literal: true

class PacketFinder
  attr_reader :string, :index, :packet, :packet_length

  def initialize(string:, packet_length:)
    @string = string.chars
    @packet_length = packet_length
    @index = 0
  end

  def perform
    loop do
      next_sliding_window

      break if start_marker?
    end

    self
  end

  def processed_characters
    @index + @packet_length - 1
  end

  private

  def next_sliding_window
    @packet = @string[@index..(@index + @packet_length - 1)]
    @index += 1
  end

  def start_marker?
    @packet.uniq.length == @packet_length
  end
end
