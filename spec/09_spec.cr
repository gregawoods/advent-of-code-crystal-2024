require "./spec_helper"

describe Day09 do
  day = Day09.new
  input = Input.from_example("09.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(1928)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(2858)
    end
  end

end
