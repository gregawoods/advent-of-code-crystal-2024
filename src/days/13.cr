class Day13 < Day

  struct Game
    property prize_x, prize_y,
      a_x, a_y,
      b_x, b_y

    def initialize(
      @a_x : Int128, @a_y : Int128,
      @b_x : Int128, @b_y : Int128,
      @prize_x : Int128, @prize_y : Int128
    )
    end
  end

  POSITION_REGEX = /X\+(\d+), Y\+(\d+)/
  PRIZE_REGEX = /X=(\d+), Y=(\d+)/

  private def parse_input(input : Input) : Array(Game)
    input.groups.map do |chunk|
      match_a = POSITION_REGEX.match(chunk[0]).as(Regex::MatchData)
      match_b = POSITION_REGEX.match(chunk[1]).as(Regex::MatchData)
      match_prize = PRIZE_REGEX.match(chunk[2]).as(Regex::MatchData)

      Game.new(
        match_a[1].to_i128,
        match_a[2].to_i128,
        match_b[1].to_i128,
        match_b[2].to_i128,
        match_prize[1].to_i128,
        match_prize[2].to_i128
      )
    end
  end

  private def solve(game) : Int128
    a, remainder = (game.prize_x * game.b_y - game.prize_y * game.b_x).divmod(game.a_x * game.b_y - game.a_y * game.b_x)
    return 0_i128 unless remainder.zero?

    b, remainder = (game.prize_x - game.a_x * a).divmod(game.b_x)
    return 0_i128 unless remainder.zero?

    3_i128 * a + b
  end

  def part1(input)
    parse_input(input).reduce(0) do |sum, game|
      sum + solve(game)
    end
  end

  def part2(input)
    parse_input(input).reduce(0_i128) do |sum, game|
      game.prize_x += 10_000_000_000_000
      game.prize_y += 10_000_000_000_000
      sum + solve(game)
    end
  end
end
