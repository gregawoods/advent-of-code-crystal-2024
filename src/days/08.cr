class Day08 < Day

  struct Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end

    def valid_position?(boundry)
      x >= 0 && y >= 0 && x < boundry && y < boundry
    end
  end

  private def parse_input(input : Input)
    hash = Hash(Char, Array(Point)).new

    input.lines.each_with_index do |line, y|
      line.each_char_with_index do |char, x|
        if char != '.'
          hash[char] ||= [] of Point
          hash[char] << Point.new(x, y)
        end
      end
    end

    hash.values
  end

  private def calculate_pairs(points)
    position = 0
    pairs = [] of Array(Point)

    points.each do |point|
      position += 1

      (position..(points.size-1)).each do |n|
        other_point = points[n]
        pairs << [point, other_point]
      end

      points
    end

    pairs
  end

  private def calculate_nodes(points, boundry)
    nodes = [] of Point

    calculate_pairs(points).each do |pair|
      a, b = pair
      rise = b.y - a.y
      run = b.x - a.x

      node_a = Point.new(a.x - run, a.y - rise)
      node_b = Point.new(b.x + run, b.y + rise)

      nodes << node_a if node_a.valid_position?(boundry)
      nodes << node_b if node_b.valid_position?(boundry)
    end

    nodes
  end

  def part1(input)
    boundry = input.lines.size

    parse_input(input)
      .map { |points| calculate_nodes(points, boundry) }
      .flatten.uniq.size
  end

  private def calculate_nodes_2(points, boundry)
    nodes = [] of Point

    calculate_pairs(points).each do |pair|
      nodes += pair
      a, b = pair
      rise = b.y - a.y
      run = b.x - a.x

      multiplier = 0
      loop do
        multiplier += 1
        node = Point.new(a.x - (run * multiplier), a.y - (rise * multiplier))

        if node.valid_position?(boundry)
          nodes << node
        else
          break
        end
      end

      multiplier = 0
      loop do
        multiplier += 1
        node = Point.new(a.x + (run * multiplier), a.y + (rise * multiplier))

        if node.valid_position?(boundry)
          nodes << node
        else
          break
        end
      end
    end

    nodes
  end

  def part2(input)
    boundry = input.lines.size

    parse_input(input)
      .map { |points| calculate_nodes_2(points, boundry) }
      .flatten.uniq.size
  end

end
