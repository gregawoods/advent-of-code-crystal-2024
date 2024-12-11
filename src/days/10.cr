class Day10 < Day

  struct Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end
  end

  private def parse_input(input : Input)
    grid = [] of Array(Int32)
    trailheads = [] of Point

    input.lines.each_with_index do |line, y|
      line.each_char_with_index do |char, x|
        grid << [] of Int32 if grid.size < (x+1)

        # dots are just for certain test inputs
        n = char == '.' ? -1 : char.to_i

        grid[x] << n
        trailheads << Point.new(x, y) if n.zero?
      end
    end

    {grid, trailheads}
  end

  private def calculate_paths(grid, trailheads) : Array(Set(Array(Point)))
    trailheads.map do |trailhead|
      reached = Set(Array(Point)).new
      paths = [[trailhead]] of Array(Point)

      loop do
        new_paths = [] of Array(Point)

        paths.each do |path|
          calculate_moves(grid, path.last).each do |move|
            cloned_path = path.map { |p| p }
            cloned_path << move

            if grid[move.x][move.y] == 9
              reached << cloned_path
            else
              new_paths << cloned_path
            end
          end
        end

        break if new_paths.empty?
        paths = new_paths
      end

      reached
    end
  end

  private def calculate_moves(grid, point : Point) : Array(Point)
    [
      Point.new(point.x - 1, point.y),
      Point.new(point.x + 1, point.y),
      Point.new(point.x, point.y - 1),
      Point.new(point.x, point.y + 1)
    ].select do |p|
      (0...grid.size).includes?(p.x) &&
        (0...grid.first.size).includes?(p.y) &&
        grid[p.x][p.y] - grid[point.x][point.y] == 1
    end
  end

  def part1(input)
    grid, trailheads = parse_input(input)

    calculate_paths(grid, trailheads).map do |paths|
      paths.map(&.last).uniq.size
    end.sum
  end

  def part2(input)
    grid, trailheads = parse_input(input)

    calculate_paths(grid, trailheads).reduce(0) { |sum, paths| sum + paths.size }
  end
end
