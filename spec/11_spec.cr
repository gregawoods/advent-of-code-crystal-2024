require "./spec_helper"

describe Day11 do
  day = Day11.new
  input = Input.from_example("11.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(55312)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(65601038650482)
    end
  end

end
