require "./spec_helper"

describe Day06 do
  day = Day06.new
  input = Input.from_example("06.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(41)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(6)
    end
  end

end
