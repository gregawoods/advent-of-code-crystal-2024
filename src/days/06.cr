class Day06 < Day

  private def parse_input(input : Input) : Tuple(Array(Array(Bool)), Int32, Int32)
    grid = [] of Array(Bool)
    ox = 0
    oy = 0

    input.lines.size.times do |y|
      input.lines[y].size.times do |x|
        grid << [] of Bool if grid.size < x + 1
        char = input.lines[y][x].to_s

        if char == "^"
          ox = x
          oy = y
        end

        grid[x] << (char == "#")
      end
    end

    {grid, ox, oy}
  end

  enum Dir
    Left
    Right
    Up
    Down
  end

  Dx = {
    Dir::Left => [-1, 0],
    Dir::Right => [1, 0],
    Dir::Up => [0, -1],
    Dir::Down => [0, 1],
  }

  Turns = {
    Dir::Left => Dir::Up,
    Dir::Right => Dir::Down,
    Dir::Up => Dir::Right,
    Dir::Down => Dir::Left,
  }

  def part1(input)
    dir = Dir::Up
    grid, x, y = parse_input(input)
    visited = Set{[x, y]}

    loop do
      mx, my = Dx[dir]
      new_x = x + mx
      new_y = y + my

      if new_x < 0 || new_y < 0 || new_x > grid[0].size - 1 || new_y > grid.size - 1
        break
      end

      if grid[new_x][new_y]
        dir = Turns[dir]
        mx, my = Dx[dir]
        new_x = x + mx
        new_y = y + my

        if new_x < 0 || new_y < 0 || new_x > grid[0].size - 1 || new_y > grid.size - 1
          break
        end
      end

      x = new_x
      y = new_y
      visited << [x, y]
    end

    visited.size
  end

  def part2(input)
    result = 0
    grid, ox, oy = parse_input(input)

    (0...grid.size).each do |y|
      (0...grid[0].size).each do |x|
        next if grid[x][y] == true || (x == ox && y == oy)

        escaped = calculate_moves(grid, ox, oy, x, y)
        result += 1 if !escaped
      end
    end

    result
  end

  def calculate_moves(grid, x, y, zx, zy) : Bool
    dir = Dir::Up
    visited = Set{[x, y, dir]}

    loop do
      mx, my = Dx[dir]
      new_x = x + mx
      new_y = y + my

      if new_x < 0 || new_y < 0 || new_x > grid.size - 1 || new_y > grid.size - 1
        break
      end

      if grid[new_x][new_y] || (new_x == zx && new_y == zy)
        dir = Turns[dir]
        mx, my = Dx[dir]
        new_x = x + mx
        new_y = y + my

        if new_x < 0 || new_y < 0 || new_x > grid.size - 1 || new_y > grid.size - 1
          break
        end

        if grid[new_x][new_y] || (new_x == zx && new_y == zy)
          dir = Turns[dir]
          mx, my = Dx[dir]
          new_x = x + mx
          new_y = y + my

          if new_x < 0 || new_y < 0 || new_x > grid.size - 1 || new_y > grid.size - 1
            break
          end
        end
      end

      x = new_x
      y = new_y

      if visited.includes?([x, y, dir])
        return false
      else
        visited << [x, y, dir]
      end
    end

    true
  end

end
