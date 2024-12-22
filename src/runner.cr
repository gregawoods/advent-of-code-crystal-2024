require "./day"
require "./days/*"
require "./strings"

class Runner
  include Strings

  DAYS = [
    Day01, Day02, Day03, Day04, Day05, Day06, Day07, Day08,
    Day09, Day10, Day11, Day12, Day13, Day14, Day15, Day16,
    Day17, Day18, Day19, Day20, Day21
  ]

  def call(day : String)
    input = Input.from_file("#{lpad(day, "0", 2)}.txt")

    n = day.to_i
    day_class = DAYS[n - 1]
    day = day_class.new

    puts "Day #{n} #{EMOJI[n % EMOJI.size]}"
    puts "• Part 1: #{day.part1(input)}"
    puts "• Part 2: #{day.part2(input)}"
  end

  EMOJI = ["🎄", "❄️", "🎁", "🎅🏼"]

  def solve_all
    DAYS.size.times do |d|
      call((d + 1).to_s)
    end
  end
end
