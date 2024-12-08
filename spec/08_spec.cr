require "./spec_helper"

describe Day08 do
  day = Day08.new
  input = Input.from_example("08.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(14)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(34)
    end
  end

end
