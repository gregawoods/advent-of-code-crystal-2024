require "./spec_helper"

describe Day01 do
  input = Input.from_example("01.txt")
  day = Day01.new

  describe "day1" do
    it "works" do
      day.part1(input).should eq(11)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(31)
    end
  end

end
