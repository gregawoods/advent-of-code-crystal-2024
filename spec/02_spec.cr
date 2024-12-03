require "./spec_helper"

describe Day02 do
  input = Input.from_example("02.txt")
  day = Day02.new

  describe "part1" do
    it "works" do
      day.part1(input).should eq(2)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(4)
    end
  end

end
