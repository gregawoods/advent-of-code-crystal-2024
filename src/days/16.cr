require "priority-queue"

class Day16 < Day

  MOVES = {
    '>' => [1, 0],
    'v' => [0, 1],
    '<' => [-1, 0],
    '^' => [0, -1]
  }

  private def parse(input)
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

    {walls, start_x, start_y, dest_x, dest_y}
  end

  private def turns(dir)
    if dir == '^'
      {'<', '>'}
    elsif dir == '>'
      {'^', 'v'}
    elsif dir == 'v'
      {'>', '<'}
    else
      {'v', '^'}
    end
  end

  # State represents an x y coordinate and facing direction
  alias State = Tuple(Int32, Int32, Char)

  def part1(input)
    walls, start_x, start_y, dest_x, dest_y = parse(input)
    queue = Priority::Queue(Array(State)).new
    queue.push 0, [{start_x, start_y, '>'}]
    visited = Set(State).new

    loop do
      item = queue.shift

      if visited.includes?(item.value.last)
        next
      else
        visited << item.value.last
      end

      path = item.value
      x, y, dir = path.last

      if x == dest_x && y == dest_y
        # print_part1(walls, path)
        return item.priority
      end

      mx, my = MOVES[dir]
      if !walls[y + my][x + mx] && !path.any? { |px, py, _d| px == x + mx && py == y + my}
        spath = path.clone
        spath << {x + mx, y + my, dir}
        queue.push item.priority + 1, spath
      end

      left, right = turns(dir)

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
    walls, start_x, start_y, dest_x, dest_y = parse(input)

    paths = [] of Array(State)

    previous_states = Hash(State, Set(State)).new do |hash, key|
      hash[key] = Set(State).new
    end

    costs = Hash(State, Int32).new do |hash, key|
      hash[key] = 999_999_999
    end

    queue = Priority::Queue(State).new
    queue.push 0, {start_x, start_y, '>'}

    final_state : State | Nil = nil

    loop do
      break if queue.empty?

      item = queue.shift
      x, y, dir = item.value

      if x == dest_x && y == dest_y
        final_state = item.value
        break
      end

      mx, my = MOVES[dir]
      if !walls[y + my][x + mx]
        new_state = {x + mx, y + my, dir}
        prev_cost = costs[new_state]
        next_cost = item.priority + 1

        if next_cost < prev_cost
          costs[new_state] = next_cost.as(Int32)
          queue.push next_cost, new_state
          previous_states[new_state] = Set{item.value}
        elsif next_cost == prev_cost
          previous_states[new_state] << item.value
        end
      end

      left, right = turns(dir)

      new_state = {x, y, left}
      prev_cost = costs[new_state]
      next_cost = item.priority + 1000

      if next_cost < prev_cost
        costs[new_state] = next_cost.as(Int32)
        queue.push next_cost, new_state
        previous_states[new_state] = Set{item.value}
      elsif next_cost == prev_cost
        previous_states[new_state] << item.value
      end

      new_state = {x, y, right}
      prev_cost = costs[new_state]
      next_cost = item.priority + 1000

      if next_cost < prev_cost
        costs[new_state] = next_cost.as(Int32)
        queue.push next_cost, new_state
        previous_states[new_state] = Set{item.value}
      elsif next_cost == prev_cost
        previous_states[new_state] << item.value
      end
    end

    if final_state
      all_states = find_all_states(final_state, start_x, start_y, previous_states)
      points = all_states.map { |x, y, _| {x, y} }.uniq
      # print_part2(walls, points)
      return points.size
    end

    0
  end

  private def find_all_states(state : State, start_x, start_y, prev_states) : Array(State)
    if state[0] == start_x && state[1] == start_y
      [state]
    else
      [state] + prev_states[state].map do |s|
        find_all_states(s, start_x, start_y, prev_states)
      end.flatten
    end
  end

  private def print_part1(walls, path)
    walls.each_with_index do |line, y|
      str = line.map_with_index do |is_wall, x|
        if is_wall
          '#'
        else
          point = path.find { |point| point[0] == x && point[1] == y }
          if point
            point[2]
          else
            '.'
          end
        end
      end.join
      puts str
    end
  end

  private def print_part2(walls, points)
    walls.each_with_index do |line, y|
      str = line.map_with_index do |is_wall, x|
        if is_wall
          '#'
        elsif points.includes?({x, y})
          'O'
        else
          '.'
        end
      end.join
      puts str
    end
  end
end
