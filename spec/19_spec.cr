require "./spec_helper"

describe Day19 do
  day = Day19.new
  input = Input.from_example("19.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(6)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(16)
    end
  end

end
