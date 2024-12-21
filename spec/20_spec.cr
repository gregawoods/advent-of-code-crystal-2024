require "./spec_helper"

describe Day20 do
  day = Day20.new
  input = Input.from_example("20.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(0)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
