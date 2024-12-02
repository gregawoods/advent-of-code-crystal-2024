require "./day"
require "./days/*"
require "./strings"

class Runner
  include Strings

  DAYS = [
    Day01, Day02
  ]

  def call(day : String)
    input = Input.from_file("#{lpad(day, "0", 2)}.txt")

    day = day.to_i
    day_class = DAYS[day - 1]
    day = day_class.new

    puts day.part1(input)
    puts day.part2(input)
  end
end
