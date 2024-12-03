class Day03 < Day
  def part1(input)
    result = 0
    regex = /mul\(\d+,\d+\)/

    input.lines.each do |line|
      line.scan(regex).each do |match|
        value = match.to_s
        x, y = value.split(",")
        x = x.sub("mul(", "").to_i
        y = y.sub(")", "").to_i
        result += x * y
      end
    end

    result
  end

  def part2(input)
    result = 0
    regex = /mul\((\d+,\d+)\)|(don't)|(do)/
    enabled = true

    input.lines.each do |line|
      line.scan(regex).each do |match|
        value = match.to_s
        if value == "do"
          enabled = true
        elsif value == "don't"
          enabled = false
        elsif enabled
          x, y = match[1].split(",")
          result += x.to_i * y.to_i
        end
      end
    end

    result
  end
end
