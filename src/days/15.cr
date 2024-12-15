class Day15 < Day

  class Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end

    def at?(x2, y2) : Bool
      x == x2 && y == y2
    end

    def value
      x + y * 100
    end
  end

  def parse(input)
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

    (0..width).each do |y|
      puts (0..height).map do |x|
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

  def part2(input)
    0
  end
end
