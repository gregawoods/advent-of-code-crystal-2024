class Day15 < Day

  class Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end

    def ==(p2)
      x == p2.x && y == p2.y
    end

    def at?(x2, y2) : Bool
      x == x2 && y == y2
    end

    def wide_box_at?(x2, y2) : Bool
      at?(x2, y2) || at?(x2 - 1, y2)
    end

    def value
      x + y * 100
    end
  end

  private def parse(input)
    walls = [] of Point
    boxes = [] of Point
    steps = [] of Char
    parsing_steps = false
    cx = 0
    cy = 0

    input.lines.each_with_index do |line, y|
      if line == ""
        parsing_steps = true
        next
      end
      if parsing_steps
        steps += line.chars
      else
        line.each_char_with_index do |char, x|
          if char == '#'
            walls << Point.new(x, y)
          elsif char == 'O'
            boxes << Point.new(x, y)
          elsif char == '@'
            cx = x
            cy = y
          end
        end
      end
    end

    {cx, cy, walls, boxes, steps}
  end

  MOVES = {
    '<' => [-1, 0],
    '>' => [1, 0],
    '^' => [0, -1],
    'v' => [0, 1]
  }

  def part1(input)
    cx, cy, walls, boxes, steps = parse(input)
    # print(walls, boxes, cx, cy)

    steps.each do |step|
      # puts "Move #{step}:"
      dx, dy = MOVES[step]
      legal_move = true
      index = 1
      affected_boxes = [] of Point

      loop do
        if walls.any? { |p| p.at?(cx + (dx * index), cy + (dy * index)) }
          legal_move = false
          break
        end

        box = boxes.find { |p| p.at?(cx + (dx * index), cy + (dy * index)) }
        if box
          affected_boxes << box
        else
          break
        end

        index += 1
      end

      if legal_move
        cx += dx
        cy += dy
        affected_boxes.each { |p|
          p.x += dx
          p.y += dy
        }
      end

      # print(walls, boxes, cx, cy)
    end

    boxes.sum(&.value)
  end

  private def print(walls, boxes, cx, cy)
    width = walls.map(&.x).max
    height = walls.map(&.y).max

    (0..height).each do |y|
      puts (0..width).map do |x|
        if walls.any? { |p| p.at?(x, y) }
          "#"
        elsif boxes.any? { |p| p.at?(x, y) }
          "O"
        elsif x == cx && y == cy
          "@"
        else
          "."
        end
      end.join
    end
    puts ""
  end

  private def parse_wide(input)
    walls = [] of Point
    boxes = [] of Point
    steps = [] of Char
    parsing_steps = false
    cx = 0
    cy = 0

    input.lines.each_with_index do |line, y|
      line = line.gsub("#", "##")
        .gsub(".", "..")
        .gsub("O", "[]")
        .gsub("@", "@.")

      if line == ""
        parsing_steps = true
        next
      end
      if parsing_steps
        steps += line.chars
      else
        line.each_char_with_index do |char, x|
          if char == '#'
            walls << Point.new(x, y)
          elsif char == '['
            boxes << Point.new(x, y)
          elsif char == '@'
            cx = x
            cy = y
          end
        end
      end
    end

    {cx, cy, walls, boxes, steps}
  end

  def part2(input)
    cx, cy, walls, boxes, steps = parse_wide(input)

    # puts "Initial state:"
    # print_wide(walls, boxes, cx, cy)

    steps.each_with_index do |step, n|
      # puts "Move #{step}:"
      dx, dy = MOVES[step]
      legal_move = true
      index = 1

      positions_moving_into = [Point.new(cx + dx, cy + dy)]
      affected_boxes = [] of Point

      loop do
        if positions_moving_into.any? do |position|
            walls.any? { |wall| position == wall }
          end
          legal_move = false
          break
        end

        overlapped = boxes.select do |box|
          !affected_boxes.includes?(box) &&
          positions_moving_into.any? do |position|
            box.wide_box_at?(position.x, position.y)
          end
        end

        if overlapped.any?
          positions_moving_into = overlapped.map do |box|
            [
              Point.new(box.x + dx, box.y + dy), Point.new(box.x + dx + 1, box.y + dy)
            ]
          end.flatten
          affected_boxes += overlapped
        else
          break
        end

        index += 1
      end

      if legal_move
        cx += dx
        cy += dy
        affected_boxes.each { |p|
          p.x += dx
          p.y += dy
        }
      end

      # print_wide(walls, boxes, cx, cy)
    end

    boxes.sum(&.value)
  end

  private def print_wide(walls, boxes, cx, cy)
    width = walls.map(&.x).max
    height = walls.map(&.y).max

    (0..height).each do |y|
      puts (0..width).map do |x|
        if walls.any? { |p| p.at?(x, y) }
          "#"
        elsif boxes.any? { |p| p.at?(x, y) }
          "["
        elsif boxes.any? { |p| p.at?(x - 1, y) }
          "]"
        elsif x == cx && y == cy
          "@"
        else
          "."
        end
      end.join
    end
    puts ""
  end
end
