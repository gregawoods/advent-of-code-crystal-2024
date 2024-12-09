class Day09 < Day

  private def parse_input(input : Input) : Array(Char | Int64)
    input.lines.first.chars.each_with_index.reduce([] of Char | Int64) do |data, (char, index)|
      if index.even?
        data += Array.new(char.to_i, (index / 2).to_i64)
      else
        data += Array.new(char.to_i, '.')
      end
    end
  end

  def checksum(data : Array(Char | Int64)) : Int64
    data.each_with_index.reduce(0_i64) do |sum, (value, index)|
      sum += value * index if value.is_a? Int64
      sum
    end
  end

  def part1(input)
    data = parse_input(input)
    position = data.size - 1

    loop do
      if data[position] != '.'
        next_available_index = data.index('.')

        if next_available_index && next_available_index < position
          data[next_available_index] = data[position]
          data[position] = '.'
        else
          break
        end
      end

      position -= 1
      break if position < 0
    end

    checksum(data)
  end

  def part2(input)
    data = parse_input(input)
    position = data.size - 1
    skipped = Set(Char | Int64).new

    loop do
      if data[position] != '.' && !skipped.includes?(data[position])
        first_instance = data.index(data[position]).as(Int32)
        length = (position - first_instance) + 1

        n = 0
        (0..position).each do |i|
          c = data[i]
          if c == '.'
            n += 1
            if n == length
              length.times do |l|
                data[i - l] = data[position - l]
                data[position - l] = '.'
              end
              break
            end
          elsif i >= position
            skipped << data[position]
            break
          else
            n = 0
          end
        end
      end

      position -= 1
      break if position < 0
    end

    checksum(data)
  end

end
