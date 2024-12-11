class Day11 < Day

  def initialize
    @cache = Hash(Int64, Hash(Int64, Int64)).new do |hash, key|
      hash[key] = Hash(Int64, Int64).new
    end
  end

  private def grow(stone : Int64) : Array(Int64)
    if stone.zero?
      [1_i64]
    elsif stone.to_s.chars.size.even?
      str = stone.to_s
      len = (str.chars.size / 2).to_i
      x = str[0..(len-1)]
      y = str[len..]
      [x.to_i64, y.to_i64]
    else
      [stone * 2024]
    end
  end

  private def calculate(stone, max_depth, depth = 0) : Int64
    return 1_i64 if depth == max_depth
    return @cache[stone][max_depth - depth] if @cache[stone].has_key?(max_depth - depth)

    sum = grow(stone).map { |s| calculate(s, max_depth, depth + 1) }.sum
    @cache[stone][max_depth - depth] = sum

    sum
  end

  private def run(input : Input, max_depth : Int32)
    input.lines.first.split(" ").sum do |stone|
      calculate(stone.to_i64, max_depth)
    end
  end

  def part1(input)
    run(input, 25)
  end

  def part2(input)
    run(input, 75)
  end

end
