# frozen_string_literal: true

class Monkey
  attr_reader :items, :operation, :test_value, :test_output, :zoo, :inspections_count

  def initialize(monkey:, zoo:)
    @items = monkey[1].split(':')[1].split(',').map(&:to_i)
    @operation = eval("-> (old) { #{monkey[2].split('=').last} }")
    @test_value = monkey[3].split.last.to_i
    @test_output = {
      true => monkey[4].split.last.to_i,
      false => monkey[5].split.last.to_i
    }
    @zoo = zoo
    @inspections_count = 0
  end

  def process(lcm:)
    while (item = @items.shift)
      @inspections_count += 1
      item = inspect_item(item, lcm)
      throw_item(item)
    end
  end

  def add_item(item)
    @items << item
  end

  private

  def inspect_item(item, lcm)
    item = @operation.call(item)
    item /= 3 if zoo.relief
    item % lcm
  end

  def throw_item(item)
    if (item % @test_value).zero?
      @zoo.throw_item(item: item, monkey: @test_output[true])
    else
      @zoo.throw_item(item: item, monkey: @test_output[false])
    end
  end
end
