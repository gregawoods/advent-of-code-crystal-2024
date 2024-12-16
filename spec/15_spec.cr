require "./spec_helper"

describe Day15 do
  day = Day15.new
  input = Input.from_example("15.txt")

  describe "part1" do
    it "works with a smaller example" do
      day.part1(
        Input.from_example("15_a.txt")
      ).should eq(2028)
    end

    it "works" do
      day.part1(input).should eq(10092)
    end
  end

  describe "part2" do
    it "works with a smaller example" do
      day.part2(
        Input.from_example("15_b.txt")
      ).should eq(618)
    end

    it "works" do
      day.part2(input).should eq(9021)
    end
  end

end
