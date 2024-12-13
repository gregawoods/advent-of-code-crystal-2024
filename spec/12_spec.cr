require "./spec_helper"

describe Day12 do
  day = Day12.new
  input = Input.from_example("12.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(140)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(80)
    end
  end

end
