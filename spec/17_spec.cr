require "./spec_helper"

describe Day17 do
  day = Day17.new
  input = Input.from_example("17.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq("4,6,3,5,6,3,5,2,1,0")
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
