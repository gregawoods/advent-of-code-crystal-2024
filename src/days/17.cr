class Day17 < Day
  def initialize
    @register_a = 0_i64
    @register_b = 0_i64
    @register_c = 0_i64
    @output = [] of Int64
  end

  def parse(input) : Array(Int64)
    lines = input.lines

    @output.clear
    @register_a = lines[0].split(": ").last.to_i64
    @register_b = lines[1].split(": ").last.to_i64
    @register_c = lines[2].split(": ").last.to_i64

    lines[4].split(": ").last.split(",").map(&.to_i64)
  end

  private def combo_operand_value(input)
    case input
    when 0..3
      input
    when 4
      @register_a
    when 5
      @register_b
    when 6
      @register_c
    else
      raise "Invalid combo operand value #{input}!"
    end
  end

  # struct Result
  #   property jump, output
  #   def initialize(@jump : Int64?, @output : Int64?)
  #   end
  # end

  def perform_operation(opcode, operand) : Int64?
    case opcode
    when 0
      @register_a = (@register_a / (2 ** combo_operand_value(operand))).to_i64
    when 1
      @register_b = @register_b | operand
    when 2
      combo_operand_value(operand) % 8
    when 3
      puts "Jump instruction!"
        if @register_a != 0
          puts "A register is #{@register_a}, doing jump"
          return operand
          # return Result.new(operand, nil)
        else
          puts "A register is #{@register_a}, not jumping"
        end
    when 4
      @register_b = @register_b | @register_c
    when 5
      @output << combo_operand_value(operand) % 8
    when 6
      @register_b = (@register_a / (combo_operand_value(operand) ** 2)).to_i64
    when 7
      @register_c = (@register_a / (combo_operand_value(operand) ** 2)).to_i64
    else
      raise "Invalid opcode value #{opcode}!"
    end

    nil
  end

  def part1(input)
    instructions = parse(input)
    output = [] of Int64
    position = 0
    iterations = 0

    loop do
      iterations += 1
      if iterations > 10_000
        puts "Giving up"
        exit
      end

      if position >= (instructions.size - 1)
        break # halt program!
      end

      puts ""
      puts "Performing #{instructions[position]} code with #{instructions[position + 1]} operand"

      result = perform_operation(
        instructions[position],
        instructions[position + 1]
      )

      if result
        position = result
        puts "Jumped to position #{position}"
      else
        position += 2
        puts "Moving to position #{position}"
      end

      puts "Resister status:"
      puts "A: #{@register_a}"
      puts "B: #{@register_b}"
      puts "C: #{@register_c}"
      puts "Current output: #{output}"
    end

    @output.join(",")
  end

  def part2(input)
    0
  end
end
