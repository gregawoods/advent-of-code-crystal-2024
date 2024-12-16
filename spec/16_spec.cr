require "./spec_helper"

describe Day16 do
  day = Day16.new
  input = Input.from_example("16.txt")

  describe "part1" do
    it "works" do
      day.part1(input).should eq(7036)
    end

    it "works with larger sample" do
      day.part1(
        input = Input.from_example("16_b.txt")
      ).should eq(11048)
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
