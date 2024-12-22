class Day21 < Day
  property sequence

  alias Point = {Int32, Int32}

  def initialize
    # # This is the FIRST keypad position that we directly control, which controls the first robot
    # @keypad_position_a = {2, 3}
    #
    @numeric_keypad_robot_position = {2, 3}

    # This is the inner-most robot, which controls the door panel
    @dir_robot_1_position = {2, 0}

    # This is the first robot, which sends signals to the inner-most robot
    @dir_robot_2_position = {2, 0}

    # keep track of the sequence
    @sequence = [] of Char
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

  def keypad_robot_press(dest : Char) : Int32
    moves = 0
    dest_point = DOOR_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @numeric_keypad_robot_position[0]
    dy = dest_point[1] - @numeric_keypad_robot_position[1]

    # puts "# Keypad robot needs to press #{dest}"
    # puts "Need to move keypad robot position from #{@numeric_keypad_robot_position} to #{dest_point}"
    # puts "Total move x #{dx} and y #{dy}"
    # puts ""

    if @numeric_keypad_robot_position[1] == 3
      # if we are currently in the bottom row, we need to move Y first
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir)
      end
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir)
      end
    else
      # else, we should move X first
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir)
      end
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir)
      end
    end

    moves += inner_robot_press('A')

    @numeric_keypad_robot_position = dest_point

    moves
  end

  def inner_robot_press(dest : Char) : Int32
    moves = 0
    dest_point = CONTROL_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @dir_robot_1_position[0]
    dy = dest_point[1] - @dir_robot_1_position[1]

    # puts "# inner robot needs to press #{dest}"
    # puts "Need to move inner robot position from #{@dir_robot_1_position} to #{dest_point}"
    # puts "Total move x #{dx} and y #{dy}"
    # puts ""

    if @dir_robot_1_position[1] == 0
      # if we are currently in the top row, move the Y axies first
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += outer_robot_press(dir)
      end
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += outer_robot_press(dir)
      end
    else
      # otherwise, move the X axis first
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += outer_robot_press(dir)
      end
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += outer_robot_press(dir)
      end
    end

    moves += outer_robot_press('A')
    @dir_robot_1_position = dest_point

    moves
  end

  def outer_robot_press(dest : Char) : Int32
    moves = 0
    dest_point = CONTROL_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @dir_robot_2_position[0]
    dy = dest_point[1] - @dir_robot_2_position[1]

    # puts "Outer robot needs to press #{dest}"
    # puts "Need to move outer robot position from #{@dir_robot_2_position} to #{dest_point}"
    # puts "Total move x #{dx} and y #{dy}"
    # puts ""
    @dir_robot_2_position = dest_point

    if dx.positive?
      dx.times do
        # puts "Keypad >"
        @sequence << '>'
        moves += 1
      end
    elsif dx.negative?
      dx.abs.times do
        # puts "Keypad <"
        @sequence << '<'
        moves += 1
      end
    end

    if dy.positive?
      dy.times do
        # puts "Keypad v"
        @sequence << 'v'
        moves += 1
      end
    elsif dy.negative?
      dy.abs.times do
        # puts "Keypad ^"
        @sequence << '^'
        moves += 1
      end
    end

    # puts "Keypad A"
    @sequence << 'A'
    moves += 1

    puts ""

    moves
  end

  def calculate_total_moves(sequence : String) : Int32
    # reset state
    @sequence.clear
    # @numeric_keypad_robot_position = {2, 3}
    # @dir_robot_1_position = {2, 0}
    # @dir_robot_2_position = {2, 0}

    sequence.chars.sum do |char|
      keypad_robot_press(char)
    end
  end

  def part1(input)
    input.lines.sum do |line|
      moves = calculate_total_moves(line)
      intval = line[0..2].to_i
      puts "Intval of #{line} is #{intval}"
      moves * intval
    end
  end

  def part2(input)
    0
  end
end
