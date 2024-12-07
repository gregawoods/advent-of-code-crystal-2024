class Day05 < Day

  struct Rule
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end
  end

  private def parse_input(input : Input) : Tuple(Array(Rule), Array(Array(Int32)))
    parsing_rules = true
    rules = [] of Rule
    lists = [] of Array(Int32)

    input.lines.each do |line|
      if line == ""
        parsing_rules = false
        next
      end

      if parsing_rules
        x, y = line.split("|")
        rules << Rule.new(x.to_i, y.to_i)
      else
        lists << line.split(",").map(&.to_i)
      end
    end

    {rules, lists}
  end

  def part1(input)
    result = 0
    rules, lists = parse_input(input)

    lists.each do |list|
      if check_list(list, rules)
        result += get_midpoint(list)
      end
    end

    result
  end

  private def check_list(list : Array(Int32), rules : Array(Rule)) : Bool
    rules.each do |rule|
      index_x = list.index(rule.x)
      index_y = list.index(rule.y)

      if index_x && index_y && index_x > index_y
        return false
      end
    end

    true
  end

  private def get_midpoint(list)
    list[((list.size + 1) / 2).to_i - 1]
  end

  def part2(input)
    result = 0
    rules, lists = parse_input(input)

    lists.each do |list|
      if check_list(list, rules) == false
        loop do
          apply_rules(list, rules)
          break if check_list(list, rules)
        end
        result += get_midpoint(list)
      end
    end

    result
  end

  private def apply_rules(list : Array(Int32), rules : Array(Rule))
    rules.each do |rule|
      index_x = list.index(rule.x)
      index_y = list.index(rule.y)

      if index_x && index_y && index_x > index_y
        list.delete(rule.x)
        list.insert(index_y, rule.x)
      end
    end
  end
end
