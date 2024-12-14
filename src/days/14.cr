class Day14 < Day

  def initialize(@width = 101, @height = 103)
    if @width.even? || @height.even?
      puts "Widdth and height are expected to be odd numbers!"
      exit
    end
  end

  class Robot
    property x, y, vx, vy

    def initialize(@x : Int32, @y : Int32, @vx : Int32, @vy : Int32)
    end
  end

  ROBO_REGX = /p=(\d+),(\d+) v=([\-\d]+),([\-\d]+)/

  def manufacture_robots(input)
    input.lines.map do |line|
      match = ROBO_REGX.match(line).as(Regex::MatchData)

      Robot.new(
        match[1].to_i,
        match[2].to_i,
        match[3].to_i,
        match[4].to_i,
      )
    end
  end

  def part1(input)
    robots = manufacture_robots(input)

    100.times do
      robots.each do |bot|
        move(bot)
      end
    end

    grouped = robots.group_by do |bot|
      {bot.x, bot.y}
    end

    mid_x = ((@width - 1) / 2).to_i
    mid_y = ((@height - 1) / 2).to_i
    quadrants = [0, 0, 0, 0]

    grouped.each do |(x, y), bots|
      if x > mid_x && y > mid_y
        quadrants[0] += bots.size
      elsif x > mid_x && y < mid_y
        quadrants[1] += bots.size
      elsif x < mid_x && y > mid_y
        quadrants[2] += bots.size
      elsif x < mid_x && y < mid_y
        quadrants[3] += bots.size
      end
    end

    quadrants.reduce(1) { |sum, n| sum * n }
  end

  def move(bot)
    bot.x += bot.vx
    bot.y += bot.vy

    bot.x = bot.x - @width if bot.x >= @width
    bot.y = bot.y - @height if bot.y >= @height
    bot.x = @width + bot.x if bot.x < 0
    bot.y = @height + bot.y if bot.y < 0
  end

  def part2(input)
    0
  end
end
