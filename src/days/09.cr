class Day09 < Day

  private def parse_input(input : Input) : Array(Char | Int64)
    index = -1

    data = input.lines.first.chars.reduce([] of Char | Int64) do |data, char|
      index += 1
      intval = char.to_i

      if index.even?
        data += Array.new(intval, (index / 2).to_i64)
      else
        data += Array.new(intval, '.')
      end
    end

    data
  end

  def checksum(data : Array(Char | Int64)) : Int64
    result = 0_i64

    data.each_with_index do |value, index|
      if value.is_a? Int64
        result += value * index
      end
    end

    result
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
