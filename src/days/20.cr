class Day20 < Day
  alias Point = Tuple(Int32, Int32)

  def build_track(input)
    start = {0, 0}
    dest = {0, 0}
    walls = Array(Point).new

    input.lines.each_with_index do |line, y|
      line.each_char_with_index do |char, x|
        if char == '#'
          walls << {x, y}
        elsif char == 'S'
          start = {x, y}
        elsif char == 'E'
          dest = {x, y}
        end
      end
    end

    track = [start]

    loop do
      position = track.last
      [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].each do |(dx, dy)|
        new_point = {position[0] + dx, position[1] + dy}
        if !track.includes?(new_point) && !walls.includes?(new_point)
          track << new_point
          break
        end
      end
      break if position == dest
    end

    {start, dest, walls, track}
  end

  def part1(input)
    start, dest, walls, track = build_track(input)
    cheats = [] of Int32

    track.each_with_index do |position, current_dist|
      [{0, 2}, {0, -2}, {2, 0}, {-2, 0}].each do |(dx, dy)|
        new_point = {position[0] + dx, position[1] + dy}

        dist = track.index(new_point)
        if dist
          cheated_dist = current_dist + 2
          if cheated_dist < dist
            cheats << dist - cheated_dist
          end
        end
      end
    end

    cheats.count { |c| c >= 100 }
  end

  def part2(input)
    start, dest, walls, track = build_track(input)
    cheats = [] of Int32

    track.each_with_index do |position, current_dist|
      track[(current_dist+1)..].each_with_index do |pos, j|
        dx = (pos[0] - position[0]).abs
        dy = (pos[1] - position[1]).abs

        if dx + dy <= 20 && dx + dy > 1
          cheats << (current_dist + j + 1) - (current_dist + dx + dy)
        end
      end
    end

    cheats.count { |c| c >= 100 }
  end
end
