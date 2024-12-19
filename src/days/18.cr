require "priority-queue"

class Day18 < Day
  alias Point = Tuple(Int32, Int32)
  alias Path = Array(Point)

  property width, height, bytes_to_read

  def initialize
    @width = 70
    @height = 70
    @bytes_to_read = 1024
  end

  private def bytes(input)
    input.lines.map do |line|
      x, y = line.split(",").map(&.to_i)
      {x, y}
    end
  end

  private def find_shortest_distance(bytes) : Int32?
    queue = Priority::Queue(Path).new
    queue.push 0, [{0, 0}]
    visited = Set(Point).new

    loop do
      item = queue.shift

      if visited.includes?(item.value.last)
        next
      else
        visited << item.value.last
      end

      move(item.value, bytes).each do |new_path|
        if new_path.last == {@width, @height}
          # print(item.value, bytes)
          return (item.priority + 1).as(Int32)
        end

        queue.push item.priority + 1, new_path
      end

      if queue.empty?
        # puts "Ran out of paths!"
        return nil
      end
    end
  end

  DIRECTIONS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ]

  def move(path : Path, bytes : Array(Point)) Array(Path)
    cx, cy = path.last

    DIRECTIONS.map do |dir|
      dx, dy = dir
      new_point = {cx + dx, cy + dy}

      if !bytes.includes?(new_point) &&
        !path.includes?(new_point) &&
        (0..@width).includes?(new_point[0]) &&
        (0..@height).includes?(new_point[1])
        p2 = path.clone
        p2 << new_point
        p2
      else
        nil
      end
    end.compact
  end

  private def print(path, bytes)
    (0..@height).each do |y|
      str = (0..@width).map do |x|
        if path.includes?({ x, y })
          'O'
        elsif bytes.includes?({ x, y })
          '#'
        else
          '.'
        end
      end
      puts str.join
    end
  end

  def part1(input)
    find_shortest_distance(
      bytes(input).first(@bytes_to_read)
    ) || 0
  end

  def part2(input)
    bytes = bytes(input)
    index = @bytes_to_read

    range_start = @bytes_to_read
    range_end = bytes.size

    loop do
      offset = ((range_end - range_start) / 2).to_i
      position = range_start + offset
      result = find_shortest_distance(bytes.first(position))

      if offset == 0
        return bytes[position].join(",")
      end

      if result
        range_start = range_start + offset
      else
        range_end = range_end - offset
      end
    end

    0
  end
end
