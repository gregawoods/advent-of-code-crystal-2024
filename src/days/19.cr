class Day19 < Day
  def initialize
    @counts = Hash(String, Int64).new
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

  def part1(input)
    patterns = input.lines[0].split(", ")

    input.lines[2..].count do |rule|
      count_possible_combinations(rule, patterns) > 0
    end
  end

  def part2(input)
    patterns = input.lines[0].split(", ")

    input.lines[2..].sum do |rule|
      count_possible_combinations(rule, patterns)
    end
  end
end
