require "./spec_helper"

describe Day21 do
  day = Day21.new
  input = Input.from_example("21.txt")

  describe "part1" do
    it "calculates a sequence" do
      day.calculate_total_moves("029A", 1).should eq("<vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A".size)
      day.calculate_total_moves("980A", 1).should eq("<v<A>>^AAAvA^A<vA<AA>>^AvAA<^A>A<v<A>A>^AAAvA<^A>A<vA>^A<A>A".size)
      day.calculate_total_moves("179A", 1).should eq("<v<A>>^A<vA<A>>^AAvAA<^A>A<v<A>>^AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A".size)
      day.calculate_total_moves("456A", 1).should eq("<v<A>>^AA<vA<A>>^AAvAA<^A>A<vA>^A<A>A<vA>^A<A>A<v<A>A>^AAvA<^A>A".size)
      day.calculate_total_moves("379A", 1).should eq("<v<A>>^AvA^A<vA<AA>>^AAvA<^A>AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A".size)
    end

    it "works" do
      # day.reset_state
      day.part1(input).should eq(126384)
    end
  end

  describe "part2" do
    it "works" do
      # not done
      # day.part2(input).should eq(0)
    end
  end
end
