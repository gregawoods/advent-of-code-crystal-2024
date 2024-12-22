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
    # moves = 0
    dest_point = DOOR_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @numeric_keypad_robot_position[0]
    dy = dest_point[1] - @numeric_keypad_robot_position[1]

    # puts "# Keypad robot needs to press #{dest}"
    # puts "Need to move keypad robot position from #{@numeric_keypad_robot_position} to #{dest_point}"
    # puts "Total move x #{dx} and y #{dy}"
    # puts ""

    sequences = [] of Int32

    # check to see if we can move horizontally first
    if DOOR_BUTTON_POSITIONS['x'] != { @numeric_keypad_robot_position[0] + dx, @numeric_keypad_robot_position[1] }
      moves = 0
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir)
      end
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir)
      end
      moves += inner_robot_press('A')
      sequences << moves
    end

    # check to see if we can move vertically first
    if DOOR_BUTTON_POSITIONS['x'] != { @numeric_keypad_robot_position[0], @numeric_keypad_robot_position[1] + dy }
      moves = 0
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += inner_robot_press(dir)
      end
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += inner_robot_press(dir)
      end
      moves += inner_robot_press('A')
      sequences << moves
    end

    @numeric_keypad_robot_position = dest_point
    sequences.min
  end

  def inner_robot_press(dest : Char) : Int32
    # moves = 0
    dest_point = CONTROL_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @dir_robot_1_position[0]
    dy = dest_point[1] - @dir_robot_1_position[1]

    sequences = [] of Int32

    # check to see if we can move horizontally first
    if CONTROL_BUTTON_POSITIONS['x'] != { @dir_robot_1_position[0] + dx, @dir_robot_1_position[1] }
      moves = 0
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += outer_robot_press(dir)
      end
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += outer_robot_press(dir)
      end
      moves += outer_robot_press('A')
      sequences << moves
    end

    # check to see if we can move vertically first
    if CONTROL_BUTTON_POSITIONS['x'] != { @dir_robot_1_position[0], @dir_robot_1_position[1] + dy }
      moves = 0
      dir = dy.positive? ? 'v' : '^'
      dy.abs.times do
        moves += outer_robot_press(dir)
      end
      dir = dx.positive? ? '>' : '<'
      dx.abs.times do
        moves += outer_robot_press(dir)
      end
      moves += outer_robot_press('A')
      sequences << moves
    end

    # return the min of the two options
    @dir_robot_1_position = dest_point
    sequences.min
  end

  def outer_robot_press(dest : Char) : Int32
    moves = 0
    dest_point = CONTROL_BUTTON_POSITIONS[dest]

    dx = dest_point[0] - @dir_robot_2_position[0]
    dy = dest_point[1] - @dir_robot_2_position[1]

    @dir_robot_2_position = dest_point

    if @dir_robot_2_position[1] == 0
      # if we are currently in the top row, move the Y axies first
      dir = dy.positive? ? 'v' : '^'
      @sequence << dir
      dy.abs.times do
        moves += 1
      end
      dir = dx.positive? ? '>' : '<'
      @sequence << dir
      dx.abs.times do
        moves += 1
      end
    else
      # otherwise, move the X axis first
      dir = dx.positive? ? '>' : '<'
      @sequence << dir
      dx.abs.times do
        moves += 1
      end
      dir = dy.positive? ? 'v' : '^'
      @sequence << dir
      dy.abs.times do
        moves += 1
      end
    end

    # puts "Keypad A"
    @sequence << 'A'
    moves += 1

    moves
  end

  def reset_state
    @numeric_keypad_robot_position = {2, 3}
    @dir_robot_1_position = {2, 0}
    @dir_robot_2_position = {2, 0}
  end

  def calculate_total_moves(sequence : String) : Int32
    @sequence.clear
    reset_state

    sequence.chars.sum do |char|
      keypad_robot_press(char)
    end
  end

  def part1(input)
    input.lines.sum do |line|
      line[0..2].to_i * calculate_total_moves(line)
    end
  end

  def part2(input)
    0
  end
end
