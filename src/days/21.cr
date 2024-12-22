class Day21 < Day
  property sequence

  alias Point = {Int32, Int32}

  def initialize
    # # This is the FIRST keypad position that we directly control, which controls the first robot
    # @keypad_position_a = {2, 3}
    #
    @numeric_keypad_robot_position = {2, 3}

    # This tracks the posiotiosn of directional robots
    @directional_robot_positions = Array(Point).new

    @cache = Hash(String, Int32).new
  end

  DOOR_BUTTON_POSITIONS = {
    '7' => {0, 0},
    '8' => {1, 0},
    '9' => {2, 0},
    '4' => {0, 1},
    '5' => {1, 1},
    '6' => {2, 1},
    '1' => {0, 2},
    '2' => {1, 2},
    '3' => {2, 2},
    'x' => {0, 3},
    '0' => {1, 3},
    'A' => {2, 3}
  }

  CONTROL_BUTTON_POSITIONS = {
    'x' => {0, 0},
    '^' => {1, 0},
    'A' => {2, 0},
    '<' => {0, 1},
    'v' => {1, 1},
    '>' => {2, 1}
  }

  def keypad_robot_press(dest : Char, max_depth : Int32) : Int32
    dest_point = DOOR_BUTTON_POSITIONS[dest]
    dx = dest_point[0] - @numeric_keypad_robot_position[0]
    dy = dest_point[1] - @numeric_keypad_robot_position[1]

    sequences = [] of Int32

    # check to see if we can move horizontally first
    if DOOR_BUTTON_POSITIONS['x'] != { @numeric_keypad_robot_position[0] + dx, @numeric_keypad_robot_position[1] }
      moves = 0
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir, 0, max_depth)
      end
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir, 0, max_depth)
      end
      moves += inner_robot_press('A', 0, max_depth)
      sequences << moves
    end

    # check to see if we can move vertically first
    if DOOR_BUTTON_POSITIONS['x'] != { @numeric_keypad_robot_position[0], @numeric_keypad_robot_position[1] + dy }
      moves = 0
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir, 0, max_depth)
      end
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir, 0, max_depth)
      end
      moves += inner_robot_press('A', 0, max_depth)
      sequences << moves
    end

    @numeric_keypad_robot_position = dest_point
    sequences.min
  end

  def inner_robot_press(dest : Char, depth : Int32, max_depth : Int32) : Int32
    # if @directional_robot_positions.size < depth + 1
    #   @directional_robot_positions << {2, 0}
    # end

    dest_point = CONTROL_BUTTON_POSITIONS[dest]
    dx = dest_point[0] - @directional_robot_positions[depth][0]
    dy = dest_point[1] - @directional_robot_positions[depth][1]

    cache_key = (@directional_robot_positions.first(depth + 1) + [depth, dest]).join("-")
    # cache_key = [@directional_robot_positions[depth][0], depth, dest].join("-")

    if @cache.has_key?(cache_key)
      # puts "Cache hit!"
      @directional_robot_positions[depth] = dest_point
      return @cache[cache_key]
    end

    sequences = [] of Int32

    if depth == max_depth
      sequences << dx.abs + dy.abs + 1
    else
      # check to see if we can move horizontally first
      if CONTROL_BUTTON_POSITIONS['x'] != { @directional_robot_positions[depth][0] + dx, @directional_robot_positions[depth][1] }
        moves = 0
        dir = dx.positive? ? '>' : '<'
        dx.abs.times do
          moves += inner_robot_press(dir, depth + 1, max_depth)
        end
        dir = dy.positive? ? 'v' : '^'
        dy.abs.times do
          moves += inner_robot_press(dir, depth + 1, max_depth)
        end
        moves += inner_robot_press('A', depth + 1, max_depth)
        sequences << moves
      end

      # check to see if we can move vertically first
      if CONTROL_BUTTON_POSITIONS['x'] != { @directional_robot_positions[depth][0], @directional_robot_positions[depth][1] + dy }
        moves = 0
        dir = dy.positive? ? 'v' : '^'
        dy.abs.times do
          moves += inner_robot_press(dir, depth + 1, max_depth)
        end
        dir = dx.positive? ? '>' : '<'
        dx.abs.times do
          moves += inner_robot_press(dir, depth + 1, max_depth)
        end
        moves += inner_robot_press('A', depth + 1, max_depth)
        sequences << moves
      end
    end

    # return the min of the two options
    @directional_robot_positions[depth] = dest_point
    @cache[cache_key] = sequences.min
    @cache[cache_key]
  end

  def calculate_total_moves(sequence : String, max_depth : Int32) : Int32
    @directional_robot_positions = (0..max_depth).map do
      {2, 0}
    end

    sequence.chars.sum do |char|
      print char
      keypad_robot_press(char, max_depth)
    end
  end

  def part1(input)
    input.lines.sum do |line|
      line[0..2].to_i * calculate_total_moves(line, 1)
    end
  end

  def part2(input)
    input.lines.sum do |line|
      puts "\n\nLine #{line}"
      line[0..2].to_i * calculate_total_moves(line, 24)
    end
  end
end
