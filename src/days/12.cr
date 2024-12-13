class Day12 < Day

  DIRECTIONS = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]

  struct Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end
  end

  struct Side
    property facing, points
    def initialize(@facing : {Int32, Int32})
      @points = Set(Point).new
    end
  end

  struct Region
    property label, points

    def initialize(@label : Char)
      @points = Set(Point).new
      @perimeter = 0
    end

    private def find_point(x, y) : Point?
      points.find { |p| p.x == x && p.y == y }
    end

    def perimeter : Int32
      points.reduce(0) do |sum, p|
        sum + 4 - DIRECTIONS.map do |dx, dy|
          find_point(p.x + dx, p.y + dy)
        end.compact.size
      end
    end

    def price : Int32
      points.size * perimeter
    end

    def sides : Array(Side)
      sides = Array(Side).new

      points.each do |point|
        DIRECTIONS.each do |dx, dy|
          if find_point(point.x + dx, point.y + dy) == nil
            next if sides.any? { |s| s.facing == {dx, dy} && s.points.includes?(point) }

            side = Side.new({dx, dy})
            side.points << point

            [1, -1].each do |z|
              delta = 0
              loop do
                delta += 1
                mx = point.x + (delta * dy * z)
                my = point.y + (delta * dx * z)

                if find_point(mx, my) && !find_point(mx + dx, my + dy)
                  side.points << find_point(mx, my).as(Point)
                else
                  break
                end
              end
            end

            sides << side
          end
        end
      end

      sides
    end

    def bulk_price : Int32
      points.size * sides.size
    end
  end

  private def explore_region(grid, region : Region, x, y)
    region.points << Point.new(x, y)

    DIRECTIONS.each do |dx, dy|
      mx = x + dx
      my = y + dy
      point = Point.new(mx, my)

      next if region.points.includes?(point)

      if mx >= 0 &&
         my >= 0 &&
         mx < grid.first.size &&
         my < grid.size &&
         grid[my][mx] == region.label
           explore_region(grid, region, mx, my)
      end
    end
  end

  private def build_garden(input) : Array(Region)
    grid = input.lines.map(&.chars)
    regions = [] of Region

    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next if regions.any? { |r| r.points.includes?(Point.new(x, y)) }
        region = Region.new(char)
        explore_region(grid, region, x, y)

        regions << region
      end
    end

    regions
  end

  def part1(input)
    build_garden(input).sum(&.price)
  end

  def part2(input)
    build_garden(input).sum(&.bulk_price)
  end

end
