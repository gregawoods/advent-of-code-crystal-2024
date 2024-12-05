class Day04 < Day

  def part1(input)
    result = 0
    grid = parse_input(input)

    (0...grid.size).each do |y|
      (0...grid[0].size).each do |x|
        result += 1 if check_string(grid, x, y, 1, 0)
        result += 1 if check_string(grid, x, y, 1, 1)
        result += 1 if check_string(grid, x, y, 1, -1)
        result += 1 if check_string(grid, x, y, 0, 1)
      end
    end

    result
  end

  private def check_string(grid, ox, oy, dx, dy) : Bool
    str = ""

    4.times do |n|
      mx = ox + (n * dx)
      my = oy + (n * dy)
      return false if mx < 0 || my < 0

      str += grid[mx][my]
    end

    str == "XMAS" || str == "SAMX"
  rescue IndexError
    false
  end

  def part2(input)
    result = 0
    grid = parse_input(input)

    (0...grid.size).each do |y|
      (0...grid[0].size).each do |x|
        result += 1 if check_string_part2(grid, x, y)
      end
    end

    result
  end

  private def check_string_part2(grid, ox, oy) : Bool
    str1 = grid[ox][oy].to_s + grid[ox+1][oy+1].to_s + grid[ox+2][oy+2].to_s
    str2 = grid[ox][oy+2].to_s + grid[ox+1][oy+1].to_s + grid[ox+2][oy].to_s

    (str1 == "MAS" || str1 == "SAM") && (str2 == "MAS" || str2 == "SAM")
  rescue IndexError
    false
  end

  private def parse_input(input : Input) : Array(Array(Char))
    grid = [] of Array(Char)

    input.lines.each do |line|
      index = 0
      line.each_char do |char|
        if grid.size < (index+1)
          grid << [] of Char
        end

        grid[index] << char
        index += 1
      end
    end

    grid
  end
end
