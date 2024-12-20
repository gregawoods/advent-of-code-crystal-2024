require "priority-queue"

class Day19 < Day
  def initialize
    @counts = Hash(String, Int64).new
  end

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

    input.lines[2..].count do |rule|
      build_towel(rule, patterns)
    end
  end

  private def count_possible_combinations(rule, patterns) : Int64
    return @counts[rule] if @counts.has_key?(rule)

    @counts[rule] = 0
    @counts[rule] += 1 if patterns.includes?(rule)

    patterns.each do |pattern|
      if rule.starts_with?(pattern)
        rest = rule[pattern.size..]
        if rest != ""
          @counts[rule] += count_possible_combinations(
            rest, patterns
          )
        end
      end
    end

    @counts[rule]
  end

  def part2(input)
    patterns = input.lines[0].split(", ")

    input.lines[2..].sum do |rule|
      count_possible_combinations(rule, patterns)
    end
  end
end
