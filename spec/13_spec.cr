require "./spec_helper"

describe Day13 do
  day = Day13.new
  input = Input.from_example("13.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(480)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(875318608908)
    end
  end

end
