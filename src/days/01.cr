class Day01 < Day
  def part1(input)
    left = [] of Int32
    right = [] of Int32
    total = 0

    input.lines.each do |line|
      l, r = line.split("   ")
      left << l.to_i
      right << r.to_i
    end

    left.sort!
    right.sort!

    left.each_with_index do |l, index|
      total += (right[index] - l).abs
    end

    total
  end

  def part2(input)
    left = [] of Int32
    right = [] of Int32
    total = 0

    input.lines.each do |line|
      l, r = line.split("   ")
      left << l.to_i
      right << r.to_i
    end

    left.each do |l|
      count = right.count(l)
      total += l * count
    end

    total
  end
end
