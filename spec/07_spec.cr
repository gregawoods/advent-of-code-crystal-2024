require "./spec_helper"

describe Day07 do
  day = Day07.new
  input = Input.from_example("07.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(3749)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(11387)
    end
  end

end
