class Day21 < Day
  property sequence

  alias Point = {Int128, Int128}

  def initialize
    # # This is the FIRST keypad position that we directly control, which controls the first robot
    # @keypad_position_a = {2, 3}
    #
    @numeric_keypad_robot_position = {2_i128, 3_i128}

    # This tracks the posiotiosn of directional robots
    @directional_robot_positions = Array(Point).new

    @cache = Hash(String, Int128).new
  end

  DOOR_BUTTON_POSITIONS = {
    '7' => {0_i128, 0_i128},
    '8' => {1_i128, 0_i128},
    '9' => {2_i128, 0_i128},
    '4' => {0_i128, 1_i128},
    '5' => {1_i128, 1_i128},
    '6' => {2_i128, 1_i128},
    '1' => {0_i128, 2_i128},
    '2' => {1_i128, 2_i128},
    '3' => {2_i128, 2_i128},
    'x' => {0_i128, 3_i128},
    '0' => {1_i128, 3_i128},
    'A' => {2_i128, 3_i128}
  } of Char => Point

  CONTROL_BUTTON_POSITIONS = {
    'x' => {0_i128, 0_i128},
    '^' => {1_i128, 0_i128},
    'A' => {2_i128, 0_i128},
    '<' => {0_i128, 1_i128},
    'v' => {1_i128, 1_i128},
    '>' => {2_i128, 1_i128}
  } of Char => Point

  def keypad_robot_press(dest : Char, max_depth : Int128) : Int128
    dest_point = DOOR_BUTTON_POSITIONS[dest]
    dx = dest_point[0] - @numeric_keypad_robot_position[0]
    dy = dest_point[1] - @numeric_keypad_robot_position[1]

    sequences = [] of Int128

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

    # check to see if we can move vertically first
    elsif DOOR_BUTTON_POSITIONS['x'] != { @numeric_keypad_robot_position[0], @numeric_keypad_robot_position[1] + dy }
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

  def inner_robot_press(dest : Char, depth : Int128, max_depth : Int128) : Int128
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

    sequences = [] of Int128

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

      # check to see if we can move vertically first
      elsif CONTROL_BUTTON_POSITIONS['x'] != { @directional_robot_positions[depth][0], @directional_robot_positions[depth][1] + dy }
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

  def calculate_total_moves(sequence : String, max_depth : Int128) : Int128
    @directional_robot_positions = (0..max_depth).map do
      {2_i128, 0_i128}
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
    input.lines.each do |line|
      puts "\n\nLine #{line}"
      puts line[0..2].to_i * calculate_total_moves(line, 24)
    end
  end
end
