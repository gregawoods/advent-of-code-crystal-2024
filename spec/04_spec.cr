require "./spec_helper"

describe Day04 do
  day = Day04.new
  input = Input.from_example("04.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(18)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(9)
    end
  end

end
