require "./spec_helper"

describe Day18 do
  day = Day18.new
  day.width = 6
  day.height = 6
  day.bytes_to_read = 12

  input = Input.from_example("18.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(22)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
