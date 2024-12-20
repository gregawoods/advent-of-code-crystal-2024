require "priority-queue"

class Day19 < Day
  private def build_towel(goal, patterns)
    queue = Priority::Queue(String).new
    queue.push 0, ""
    visited = Set(String).new

    loop do
      return false if queue.empty?

      candidate = queue.pop.value
      return true if candidate == goal

      find_strings(goal, candidate, patterns).each do |c|
        if !visited.includes?(c)
          visited << c
          queue.push c.size, c
        end
      end
    end

    false
  end

  private def find_strings(goal, towel, patterns) : Array(String)
    offset = 0
    strings = [] of String

    loop do
      needle = goal[towel.size...(goal.size - offset)]
      break if needle == ""

      found = patterns.find { |p| p == needle }

      if found
        strings << towel + found
      end

      offset += 1
    end

    strings
  end

  def part1(input)
    patterns = input.lines[0].split(", ")
    rules = input.lines[2..]

    rules.count do |rule|
      build_towel(rule, patterns)
    end
  end

  def part2(input)
    0
  end
end
