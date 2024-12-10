require "./spec_helper"

describe Day10 do
  day = Day10.new
  input = Input.from_example("10.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(36)
    end
  end

  describe "part2" do
    it "works with simple path" do
      day.part2(Input.from_example("10_b.txt")).should eq(3)
    end

    it "works" do
      day.part2(input).should eq(81)
    end
  end

end
