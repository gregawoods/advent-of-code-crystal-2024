require "./spec_helper"

describe Day03 do
  day = Day03.new

  describe "part1" do
    it "works" do
      input = Input.from_example("03_a.txt")
      day.part1(input).should eq(161)
    end
  end

  describe "part2" do
    it "works" do
      input = Input.from_example("03_b.txt")
      day.part2(input).should eq(48)
    end
  end

end
