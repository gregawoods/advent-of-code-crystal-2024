require "./spec_helper"

describe Day14 do
  day = Day14.new(11, 7)
  input = Input.from_example("14.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(12)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
