class Day02 < Day
  def part1(input)
    result = 0

    input.lines.each do |line|
      levels = line.split(" ").map { |it| it.to_i }

      result += 1 if line_safe?(levels)
    end

    result
  end

  def line_safe?(levels)
    dir = "?"
    prev = -1

    levels.each do |level|
      if prev == -1
        prev = level
      else
        diff = (level - prev).abs
        return false if diff > 3 || diff == 0

        if dir == "?"
          dir = level > prev ? "asc" : "desc"
        elsif dir == "asc" && level < prev
          return false
        elsif dir == "desc" && prev < level
          return false
        end

        prev = level
      end
    end

    true
  end

  def part2(input)
    result = 0

    input.lines.each_with_index do |line, i|
      levels = line.split(" ").map { |it| it.to_i }

      if line_safe?(levels)
        result += 1
      else
        levels.size.times do |n|
          clone = levels.clone
          clone.delete_at(n)
          if line_safe?(clone)
            result += 1
            break
          end
        end
      end
    end

    result
  end
end
