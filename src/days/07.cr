class Day07 < Day

  struct Equation
    property value, numbers
    def initialize(@value : Int64, @numbers : Array(Int64))
    end
  end

  private def parse_input(input : Input) : Array(Equation)
    input.lines.map do |line|
      start, rest = line.split(":")
      nums = rest.split(" ").reject { |n| n == "" }.map { |n| Int64.new(n) }
      Equation.new(Int64.new(start), nums)
    end
  end

  private def equation_solvable?(eq : Equation)
    solve_recursive(eq, "+", eq.numbers.first, 0) || solve_recursive(eq, "*", eq.numbers.first, 0)
  end

  private def solve_recursive(eq : Equation, operation : String, accumulator : Int64, index : Int32) : Bool
    next_val = eq.numbers[index + 1]

    if operation == "+"
      accumulator = accumulator + next_val
    else
      accumulator = accumulator * next_val
    end

    if accumulator > eq.value
      false
    elsif index == (eq.numbers.size - 2)
      accumulator == eq.value
    else
      solve_recursive(eq, "+", accumulator, index + 1) ||
      solve_recursive(eq, "*", accumulator, index + 1)
    end
  end

  def part1(input)
    parse_input(input)
      .select { |eq| equation_solvable?(eq) }
      .map { |eq| eq.value }.sum
  end

  private def equation_solvable_concat?(eq : Equation)
    solve_recursive_concat(eq, "+", eq.numbers.first, 0) ||
      solve_recursive_concat(eq, "*", eq.numbers.first, 0) ||
      solve_recursive_concat(eq, "||", eq.numbers.first, 0)
  end

  private def solve_recursive_concat(eq : Equation, operation : String, accumulator : Int64, index : Int32) : Bool
    next_val = eq.numbers[index + 1]

    if operation == "||"
      accumulator = Int64.new(accumulator.to_s + next_val.to_s)
    elsif operation == "+"
      accumulator = accumulator + next_val
    else
      accumulator = accumulator * next_val
    end

    if accumulator > eq.value
      false
    elsif index == (eq.numbers.size - 2)
      accumulator == eq.value
    else
      solve_recursive_concat(eq, "+", accumulator, index + 1) ||
        solve_recursive_concat(eq, "*", accumulator, index + 1) ||
        solve_recursive_concat(eq, "||", accumulator, index + 1)
    end
  end

  def part2(input)
    parse_input(input)
      .select { |eq| equation_solvable_concat?(eq) }
      .map { |eq| eq.value }.sum
  end
end
