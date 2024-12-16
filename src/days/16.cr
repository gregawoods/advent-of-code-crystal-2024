require "priority-queue"

class Day16 < Day

  MOVES = {
    '>' => [1, 0],
    'v' => [0, 1],
    '<' => [-1, 0],
    '^' => [0, -1]
  }

  def part1(input)
    walls = [] of Array(Bool)
    start_x = 0
    start_y = 0
    dest_x = 0
    dest_y = 0

    input.lines.each_with_index do |line, y|
      walls << [] of Bool
      line.each_char_with_index do |char, x|
        walls[y] << (char == '#')

        if char == 'S'
          start_x = x
          start_y = y
        elsif char == 'E'
          dest_x = x
          dest_y = y
        end
      end
    end

    # puts "Staring at #{start_x}, #{start_y}"
    # puts "Destination #{dest_x}, #{dest_y}"
    # pp walls

    queue = Priority::Queue(
      Array(Tuple(Int32, Int32, Char))
    ).new
    queue.push 0, [{start_x, start_y, '>'}]

    i = 0

    loop do
      item = queue.shift
      path = item.value
      x, y, dir = path.last

      i += 1
      # if item.priority > 11048 || i > 200_000
      #   puts "Too many tries"
      #   pp item
      #   exit
      # end

      # puts "At #{x} #{y} facing #{dir}, priority #{item.priority}"

      if x == dest_x && y == dest_y
        return item.priority
      end

      # check moving straight
      mx, my = MOVES[dir]
      if !walls[y + my][x + mx] && !path.any? { |px, py, _d| px == x + mx && py == y + my}
        path = path.clone
        path << {x + mx, y + my, dir}
        queue.push item.priority + 1, path
      end

      if dir == '^'
        left = '<'
        right = '>'
      elsif dir == '>'
        left = '^'
        right = 'v'
      elsif dir == 'v'
        left = '>'
        right = '<'
      else
        left = 'v'
        right = '^'
      end

      if !path.includes?({x, y, left})
        lpath = path.clone
        lpath << {x, y, left}
        queue.push(item.priority + 1000, lpath)
      end

      if !path.includes?({x, y, right})
        rpath = path.clone
        rpath << {x, y, right}
        queue.push(item.priority + 1000, rpath)
      end
    end

    0
  end

  def part2(input)
    0
  end
end
