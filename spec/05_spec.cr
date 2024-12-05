require "./spec_helper"

describe Day05 do
  day = Day05.new
  input = Input.from_example("05.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(143)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(123)
    end
  end

end
